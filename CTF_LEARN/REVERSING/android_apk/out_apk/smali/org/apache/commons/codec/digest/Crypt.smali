.class public Lorg/apache/commons/codec/digest/Crypt;
.super Ljava/lang/Object;
.source "Crypt.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static crypt(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    const/4 v0, 0x0

    .line 106
    invoke-static {p0, v0}, Lorg/apache/commons/codec/digest/Crypt;->crypt(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static crypt(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .line 167
    sget-object v0, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p0, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p0

    invoke-static {p0, p1}, Lorg/apache/commons/codec/digest/Crypt;->crypt([BLjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static crypt([B)Ljava/lang/String;
    .locals 1

    const/4 v0, 0x0

    .line 52
    invoke-static {p0, v0}, Lorg/apache/commons/codec/digest/Crypt;->crypt([BLjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static crypt([BLjava/lang/String;)Ljava/lang/String;
    .locals 1

    if-nez p1, :cond_0

    .line 76
    invoke-static {p0}, Lorg/apache/commons/codec/digest/Sha2Crypt;->sha512Crypt([B)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_0
    const-string v0, "$6$"

    .line 77
    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 78
    invoke-static {p0, p1}, Lorg/apache/commons/codec/digest/Sha2Crypt;->sha512Crypt([BLjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_1
    const-string v0, "$5$"

    .line 79
    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 80
    invoke-static {p0, p1}, Lorg/apache/commons/codec/digest/Sha2Crypt;->sha256Crypt([BLjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_2
    const-string v0, "$1$"

    .line 81
    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 82
    invoke-static {p0, p1}, Lorg/apache/commons/codec/digest/Md5Crypt;->md5Crypt([BLjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 84
    :cond_3
    invoke-static {p0, p1}, Lorg/apache/commons/codec/digest/UnixCrypt;->crypt([BLjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method
