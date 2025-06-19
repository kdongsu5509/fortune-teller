package com.jangpyeong.fortuneteller.common.config;

import com.google.auth.oauth2.ServiceAccountCredentials;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;
import java.io.IOException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.core.io.Resource;

@Configuration
@Profile("!test")
public class GCSConfig {

    @Value("${spring.cloud.gcp.storage.credentials.project-id}")
    private String ProjectId;

    @Value("classpath:gcs_bucket_manager.json")
    private Resource gcpKey;

    @Bean
    public Storage storage() throws IOException {
        return StorageOptions.newBuilder()
                .setCredentials(
                        ServiceAccountCredentials.fromStream(gcpKey.getInputStream()))
                .build()
                .getService();
    }
}