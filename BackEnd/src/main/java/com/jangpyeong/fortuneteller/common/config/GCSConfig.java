package com.jangpyeong.fortuneteller.common.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;
import java.io.IOException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

@Configuration
public class GCSConfig {

    /**
     * Google Cloud Storage (GCS) client bean configuration.
     */

    @Value("${spring.cloud.gcp.storage.credentials.project-id}")
    private String ProjectId;

    @Value("${spring.cloud.gcp.storage.credentials.location}")
    private String credentialsPath;

    @Bean
    public Storage storage() throws IOException {

        ClassPathResource resource = new ClassPathResource(credentialsPath);
        GoogleCredentials credentials = GoogleCredentials.fromStream(resource.getInputStream());

        return StorageOptions.newBuilder()
                .setCredentials(credentials)
                .setProjectId(ProjectId)
                .build().getService();
    }
}