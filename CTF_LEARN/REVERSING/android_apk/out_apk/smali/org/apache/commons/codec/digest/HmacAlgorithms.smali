.class public final enum Lorg/apache/commons/codec/digest/HmacAlgorithms;
.super Ljava/lang/Enum;
.source "HmacAlgorithms.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lorg/apache/commons/codec/digest/HmacAlgorithms;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lorg/apache/commons/codec/digest/HmacAlgorithms;

.field public static final enum HMAC_MD5:Lorg/apache/commons/codec/digest/HmacAlgorithms;

.field public static final enum HMAC_SHA_1:Lorg/apache/commons/codec/digest/HmacAlgorithms;

.field public static final enum HMAC_SHA_224:Lorg/apache/commons/codec/digest/HmacAlgorithms;

.field public static final enum HMAC_SHA_256:Lorg/apache/commons/codec/digest/HmacAlgorithms;

.field public static final enum HMAC_SHA_384:Lorg/apache/commons/codec/digest/HmacAlgorithms;

.field public static final enum HMAC_SHA_512:Lorg/apache/commons/codec/digest/HmacAlgorithms;


# instance fields
.field private final name:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 9

    .line 47
    new-instance v0, Lorg/apache/commons/codec/digest/HmacAlgorithms;

    const/4 v1, 0x0

    const-string v2, "HMAC_MD5"

    const-string v3, "HmacMD5"

    invoke-direct {v0, v2, v1, v3}, Lorg/apache/commons/codec/digest/HmacAlgorithms;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lorg/apache/commons/codec/digest/HmacAlgorithms;->HMAC_MD5:Lorg/apache/commons/codec/digest/HmacAlgorithms;

    .line 55
    new-instance v0, Lorg/apache/commons/codec/digest/HmacAlgorithms;

    const/4 v2, 0x1

    const-string v3, "HMAC_SHA_1"

    const-string v4, "HmacSHA1"

    invoke-direct {v0, v3, v2, v4}, Lorg/apache/commons/codec/digest/HmacAlgorithms;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lorg/apache/commons/codec/digest/HmacAlgorithms;->HMAC_SHA_1:Lorg/apache/commons/codec/digest/HmacAlgorithms;

    .line 64
    new-instance v0, Lorg/apache/commons/codec/digest/HmacAlgorithms;

    const/4 v3, 0x2

    const-string v4, "HMAC_SHA_224"

    const-string v5, "HmacSHA224"

    invoke-direct {v0, v4, v3, v5}, Lorg/apache/commons/codec/digest/HmacAlgorithms;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lorg/apache/commons/codec/digest/HmacAlgorithms;->HMAC_SHA_224:Lorg/apache/commons/codec/digest/HmacAlgorithms;

    .line 72
    new-instance v0, Lorg/apache/commons/codec/digest/HmacAlgorithms;

    const/4 v4, 0x3

    const-string v5, "HMAC_SHA_256"

    const-string v6, "HmacSHA256"

    invoke-direct {v0, v5, v4, v6}, Lorg/apache/commons/codec/digest/HmacAlgorithms;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lorg/apache/commons/codec/digest/HmacAlgorithms;->HMAC_SHA_256:Lorg/apache/commons/codec/digest/HmacAlgorithms;

    .line 80
    new-instance v0, Lorg/apache/commons/codec/digest/HmacAlgorithms;

    const/4 v5, 0x4

    const-string v6, "HMAC_SHA_384"

    const-string v7, "HmacSHA384"

    invoke-direct {v0, v6, v5, v7}, Lorg/apache/commons/codec/digest/HmacAlgorithms;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lorg/apache/commons/codec/digest/HmacAlgorithms;->HMAC_SHA_384:Lorg/apache/commons/codec/digest/HmacAlgorithms;

    .line 88
    new-instance v0, Lorg/apache/commons/codec/digest/HmacAlgorithms;

    const/4 v6, 0x5

    const-string v7, "HMAC_SHA_512"

    const-string v8, "HmacSHA512"

    invoke-direct {v0, v7, v6, v8}, Lorg/apache/commons/codec/digest/HmacAlgorithms;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lorg/apache/commons/codec/digest/HmacAlgorithms;->HMAC_SHA_512:Lorg/apache/commons/codec/digest/HmacAlgorithms;

    const/4 v7, 0x6

    new-array v7, v7, [Lorg/apache/commons/codec/digest/HmacAlgorithms;

    .line 39
    sget-object v8, Lorg/apache/commons/codec/digest/HmacAlgorithms;->HMAC_MD5:Lorg/apache/commons/codec/digest/HmacAlgorithms;

    aput-object v8, v7, v1

    sget-object v1, Lorg/apache/commons/codec/digest/HmacAlgorithms;->HMAC_SHA_1:Lorg/apache/commons/codec/digest/HmacAlgorithms;

    aput-object v1, v7, v2

    sget-object v1, Lorg/apache/commons/codec/digest/HmacAlgorithms;->HMAC_SHA_224:Lorg/apache/commons/codec/digest/HmacAlgorithms;

    aput-object v1, v7, v3

    sget-object v1, Lorg/apache/commons/codec/digest/HmacAlgorithms;->HMAC_SHA_256:Lorg/apache/commons/codec/digest/HmacAlgorithms;

    aput-object v1, v7, v4

    sget-object v1, Lorg/apache/commons/codec/digest/HmacAlgorithms;->HMAC_SHA_384:Lorg/apache/commons/codec/digest/HmacAlgorithms;

    aput-object v1, v7, v5

    aput-object v0, v7, v6

    sput-object v7, Lorg/apache/commons/codec/digest/HmacAlgorithms;->$VALUES:[Lorg/apache/commons/codec/digest/HmacAlgorithms;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 92
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 93
    iput-object p3, p0, Lorg/apache/commons/codec/digest/HmacAlgorithms;->name:Ljava/lang/String;

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lorg/apache/commons/codec/digest/HmacAlgorithms;
    .locals 1

    .line 39
    const-class v0, Lorg/apache/commons/codec/digest/HmacAlgorithms;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lorg/apache/commons/codec/digest/HmacAlgorithms;

    return-object p0
.end method

.method public static values()[Lorg/apache/commons/codec/digest/HmacAlgorithms;
    .locals 1

    .line 39
    sget-object v0, Lorg/apache/commons/codec/digest/HmacAlgorithms;->$VALUES:[Lorg/apache/commons/codec/digest/HmacAlgorithms;

    invoke-virtual {v0}, [Lorg/apache/commons/codec/digest/HmacAlgorithms;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lorg/apache/commons/codec/digest/HmacAlgorithms;

    return-object v0
.end method


# virtual methods
.method public getName()Ljava/lang/String;
    .locals 1

    .line 103
    iget-object v0, p0, Lorg/apache/commons/codec/digest/HmacAlgorithms;->name:Ljava/lang/String;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .line 122
    iget-object v0, p0, Lorg/apache/commons/codec/digest/HmacAlgorithms;->name:Ljava/lang/String;

    return-object v0
.end method
