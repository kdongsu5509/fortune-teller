package com.jangpyeong.fortuneteller.infra;

import com.google.cloud.WriteChannel;
import com.google.cloud.storage.BlobId;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Storage;
import com.jangpyeong.fortuneteller.domain.analyze.application.ImageService;
import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class ImageServiceImpl implements ImageService {

    private final Storage storage;

    @Value("${spring.cloud.gcp.storage.bucket}")
    private String bucketName;

    @Override
    public String uploadImgae(MultipartFile file) throws IOException {
        String uuid = UUID.randomUUID().toString();
        String originalFilename = file.getOriginalFilename();
        String contentType = file.getContentType();
        String extension = "";

        if (originalFilename != null && originalFilename.contains(".")) {
            extension = originalFilename.substring(originalFilename.lastIndexOf('.'));
        }

        String objectName = uuid + extension;

        BlobId blobId = BlobId.of(bucketName, objectName);
        BlobInfo blobInfo = BlobInfo.newBuilder(blobId)
                .setContentType(contentType)
                .build();

        try (WriteChannel writer = storage.writer(blobInfo);
             InputStream inputStream = file.getInputStream()) {
            byte[] buffer = new byte[1024];
            int limit;
            while ((limit = inputStream.read(buffer)) >= 0) {
                writer.write(ByteBuffer.wrap(buffer, 0, limit));
            }
        }

        return String.format("https://storage.googleapis.com/%s/%s", bucketName, objectName);
    }

    @Override
    public void deleteImage(String imgAddress) {
        String objectName = imgAddress.substring(imgAddress.lastIndexOf("/") + 1);
        boolean deleted = storage.delete(bucketName, objectName);
        if (deleted) {
            log.info("이미지 삭제 완료: {}", imgAddress);
        } else {
            log.warn("삭제 실패 또는 이미지 없음: {}", imgAddress);
        }
    }

    @Override
    public String getImageUrl(String imgAddress) {
        return String.format("https://storage.googleapis.com/%s/%s", bucketName, imgAddress);
    }
}
