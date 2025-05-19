package com.jangpyeong.fortuneteller.infra.cloud;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;
import java.io.IOException;
import java.io.InputStream;
import java.util.Optional;
import java.util.UUID;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
@Component
public class ImageServiceImpl implements ImageService {

    @Value("${spring.cloud.gcp.storage.credentials.location}")
    private String keyFileLocation;

    @Value("${spring.cloud.gcp.storage.bucket}")
    private String bucketName;

    private Storage getStorage() throws IOException {
        InputStream keyFile = new ClassPathResource(
                keyFileLocation.replace("classpath:", "")
        ).getInputStream();

        return StorageOptions.newBuilder()
                .setCredentials(GoogleCredentials.fromStream(keyFile))
                .build()
                .getService();
    }

    @Override
    public String uploadImgae(MultipartFile file) throws IOException {
        if (file.isEmpty()) {
            return null;
        }

        String ext = Optional.ofNullable(file.getOriginalFilename())
                .filter(name -> name.contains("."))
                .map(name -> name.substring(name.lastIndexOf(".")))
                .orElse(".png");

        String uuid = UUID.randomUUID().toString() + ext;

        Storage storage = getStorage();

        BlobInfo blobInfo = BlobInfo.newBuilder(bucketName, uuid)
                .setContentType(file.getContentType())
                .build();

        storage.create(blobInfo, file.getInputStream());

        return "https://storage.googleapis.com/" + bucketName + "/" + uuid;
    }

    @Override
    public String uploadImage(MultipartFile file) throws IOException {
        return "";
    }

    @Override
    public void deleteImage(String imgUrl) {
        String key = imgUrl.substring(imgUrl.lastIndexOf("/") + 1);
        try {
            Storage storage = getStorage();
            storage.delete(bucketName, key);
        } catch (IOException e) {
            throw new RuntimeException("Failed to delete image: " + key, e);
        }
    }

    @Override
    public String getImageUrl(String imgUrl) {
        String key = imgUrl.substring(imgUrl.lastIndexOf("/") + 1);
        return "https://storage.googleapis.com/" + bucketName + "/" + key;
    }
}
