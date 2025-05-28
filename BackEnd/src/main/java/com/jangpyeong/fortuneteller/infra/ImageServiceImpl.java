package com.jangpyeong.fortuneteller.infra;

import com.google.cloud.WriteChannel;
import com.google.cloud.storage.BlobId;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Storage;
import com.jangpyeong.fortuneteller.domain.image.application.ImageService;
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
    public String upload(MultipartFile file) {
        UUID uuid = UUID.randomUUID();
        BlobInfo blobInfo = createBlobInfo(uuid, file.getContentType());

        writeImageToGCS(file, blobInfo);

        return String.format("https://storage.googleapis.com/%s/%s", bucketName, uuid);
    }

    private void writeImageToGCS(MultipartFile file, BlobInfo blobInfo) {
        try (WriteChannel writer = storage.writer(blobInfo);
             InputStream inputStream = file.getInputStream()) {
            transferStreamToChannel(writer, inputStream);
        } catch (IOException e) {
            throw new ImageUploadException();
        }
    }

    private void transferStreamToChannel(WriteChannel writer, InputStream inputStream) throws IOException {
        byte[] buffer = new byte[1024];
        int bytesRead;
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            writer.write(ByteBuffer.wrap(buffer, 0, bytesRead));
        }
    }

    private BlobInfo createBlobInfo(UUID uuid, String contentType) {
        return BlobInfo.newBuilder(BlobId.of(bucketName, uuid.toString()))
                .setContentType(contentType)
                .build();
    }

    @Override
    public void delete(String imgAddress) {
        String objectName = imgAddress.substring(imgAddress.lastIndexOf("/") + 1);
        boolean deleted = storage.delete(bucketName, objectName);
        if (deleted) {
            log.info("이미지 삭제 완료: {}", imgAddress);
        } else {
            log.warn("삭제 실패 또는 이미지 없음: {}", imgAddress);
        }
    }

    private static class ImageUploadException extends RuntimeException {
    }
}
