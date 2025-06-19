//package com.jangpyeong.fortuneteller.domain.purchase.domain;
//
//import com.jangpyeong.fortuneteller.domain.user.domain.User;
//import jakarta.persistence.Column;
//import jakarta.persistence.Entity;
//import jakarta.persistence.FetchType;
//import jakarta.persistence.GeneratedValue;
//import jakarta.persistence.GenerationType;
//import jakarta.persistence.Id;
//import jakarta.persistence.JoinColumn;
//import jakarta.persistence.ManyToOne;
//import java.time.Instant;
//import java.time.LocalDateTime;
//import java.time.ZoneId;
//import lombok.AccessLevel;
//import lombok.AllArgsConstructor;
//import lombok.Builder;
//import lombok.Getter;
//import lombok.NoArgsConstructor;
//
//@Entity
//@Getter
//@NoArgsConstructor(access = AccessLevel.PROTECTED)
//@AllArgsConstructor
//@Builder
//public class Purchase {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private Long id;
//
//    private String productId;
//
//    @Column(unique = true, nullable = false)
//    private String purchaseToken;
//
//    private boolean acknowledged;
//
//    private boolean consumed;
//
//    private LocalDateTime purchaseTime;
//
//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "user_email", nullable = false)
//    private User user;
//
//    public static Purchase fromGooglePlay(User user, String productId, String token,
//                                          com.google.api.services.androidpublisher.model.ProductPurchase googlePurchase) {
//        return Purchase.builder()
//                .user(user)
//                .productId(productId)
//                .purchaseToken(token)
//                .acknowledged(googlePurchase.getAcknowledgementState() != null
//                        && googlePurchase.getAcknowledgementState() == 1)
//                .consumed(googlePurchase.getConsumptionState() != null && googlePurchase.getConsumptionState() == 1)
//                .purchaseTime(Instant.ofEpochMilli(googlePurchase.getPurchaseTimeMillis())
//                        .atZone(ZoneId.systemDefault())
//                        .toLocalDateTime())
//                .build();
//    }
//
//    public void setUser(User user) {
//        this.user = user;
//    }
//}
