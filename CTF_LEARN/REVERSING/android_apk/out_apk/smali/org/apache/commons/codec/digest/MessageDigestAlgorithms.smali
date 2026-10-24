.class public Lorg/apache/commons/codec/digest/MessageDigestAlgorithms;
.super Ljava/lang/Object;
.source "MessageDigestAlgorithms.java"


# static fields
.field public static final MD2:Ljava/lang/String; = "MD2"

.field public static final MD5:Ljava/lang/String; = "MD5"

.field public static final SHA3_224:Ljava/lang/String; = "SHA3-224"

.field public static final SHA3_256:Ljava/lang/String; = "SHA3-256"

.field public static final SHA3_384:Ljava/lang/String; = "SHA3-384"

.field public static final SHA3_512:Ljava/lang/String; = "SHA3-512"

.field public static final SHA_1:Ljava/lang/String; = "SHA-1"

.field public static final SHA_224:Ljava/lang/String; = "SHA-224"

.field public static final SHA_256:Ljava/lang/String; = "SHA-256"

.field public static final SHA_384:Ljava/lang/String; = "SHA-384"

.field public static final SHA_512:Ljava/lang/String; = "SHA-512"

.field public static final SHA_512_224:Ljava/lang/String; = "SHA-512/224"

.field public static final SHA_512_256:Ljava/lang/String; = "SHA-512/256"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 169
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static values()[Ljava/lang/String;
    .locals 3

    const/16 v0, 0xd

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "MD2"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "MD5"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "SHA-1"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "SHA-224"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "SHA-256"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "SHA-384"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "SHA-512"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "SHA-512/224"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "SHA-512/256"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "SHA3-224"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "SHA3-256"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "SHA3-384"

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, "SHA3-512"

    aput-object v2, v0, v1

    return-object v0
.end method
