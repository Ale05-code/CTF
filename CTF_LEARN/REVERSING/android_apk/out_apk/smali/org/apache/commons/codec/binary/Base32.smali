.class public Lorg/apache/commons/codec/binary/Base32;
.super Lorg/apache/commons/codec/binary/BaseNCodec;
.source "Base32.java"


# static fields
.field private static final BITS_PER_ENCODED_BYTE:I = 0x5

.field private static final BYTES_PER_ENCODED_BLOCK:I = 0x8

.field private static final BYTES_PER_UNENCODED_BLOCK:I = 0x5

.field private static final CHUNK_SEPARATOR:[B

.field private static final DECODE_TABLE:[B

.field private static final ENCODE_TABLE:[B

.field private static final HEX_DECODE_TABLE:[B

.field private static final HEX_ENCODE_TABLE:[B

.field private static final MASK_1BITS:J = 0x1L

.field private static final MASK_2BITS:J = 0x3L

.field private static final MASK_3BITS:J = 0x7L

.field private static final MASK_4BITS:J = 0xfL

.field private static final MASK_5BITS:I = 0x1f

.field private static final MASK_6BITS:J = 0x3fL

.field private static final MASK_7BITS:J = 0x7fL


# instance fields
.field private final decodeSize:I

.field private final decodeTable:[B

.field private final encodeSize:I

.field private final encodeTable:[B

.field private final lineSeparator:[B


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const/4 v0, 0x2

    new-array v0, v0, [B

    .line 59
    fill-array-data v0, :array_0

    sput-object v0, Lorg/apache/commons/codec/binary/Base32;->CHUNK_SEPARATOR:[B

    const/16 v0, 0x7b

    new-array v0, v0, [B

    .line 66
    fill-array-data v0, :array_1

    sput-object v0, Lorg/apache/commons/codec/binary/Base32;->DECODE_TABLE:[B

    const/16 v0, 0x20

    new-array v1, v0, [B

    .line 83
    fill-array-data v1, :array_2

    sput-object v1, Lorg/apache/commons/codec/binary/Base32;->ENCODE_TABLE:[B

    const/16 v1, 0x77

    new-array v1, v1, [B

    .line 94
    fill-array-data v1, :array_3

    sput-object v1, Lorg/apache/commons/codec/binary/Base32;->HEX_DECODE_TABLE:[B

    new-array v0, v0, [B

    .line 111
    fill-array-data v0, :array_4

    sput-object v0, Lorg/apache/commons/codec/binary/Base32;->HEX_ENCODE_TABLE:[B

    return-void

    nop

    :array_0
    .array-data 1
        0xdt
        0xat
    .end array-data

    nop

    :array_1
    .array-data 1
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        0x1at
        0x1bt
        0x1ct
        0x1dt
        0x1et
        0x1ft
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        0x0t
        0x1t
        0x2t
        0x3t
        0x4t
        0x5t
        0x6t
        0x7t
        0x8t
        0x9t
        0xat
        0xbt
        0xct
        0xdt
        0xet
        0xft
        0x10t
        0x11t
        0x12t
        0x13t
        0x14t
        0x15t
        0x16t
        0x17t
        0x18t
        0x19t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        0x0t
        0x1t
        0x2t
        0x3t
        0x4t
        0x5t
        0x6t
        0x7t
        0x8t
        0x9t
        0xat
        0xbt
        0xct
        0xdt
        0xet
        0xft
        0x10t
        0x11t
        0x12t
        0x13t
        0x14t
        0x15t
        0x16t
        0x17t
        0x18t
        0x19t
    .end array-data

    :array_2
    .array-data 1
        0x41t
        0x42t
        0x43t
        0x44t
        0x45t
        0x46t
        0x47t
        0x48t
        0x49t
        0x4at
        0x4bt
        0x4ct
        0x4dt
        0x4et
        0x4ft
        0x50t
        0x51t
        0x52t
        0x53t
        0x54t
        0x55t
        0x56t
        0x57t
        0x58t
        0x59t
        0x5at
        0x32t
        0x33t
        0x34t
        0x35t
        0x36t
        0x37t
    .end array-data

    :array_3
    .array-data 1
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        0x0t
        0x1t
        0x2t
        0x3t
        0x4t
        0x5t
        0x6t
        0x7t
        0x8t
        0x9t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        0xat
        0xbt
        0xct
        0xdt
        0xet
        0xft
        0x10t
        0x11t
        0x12t
        0x13t
        0x14t
        0x15t
        0x16t
        0x17t
        0x18t
        0x19t
        0x1at
        0x1bt
        0x1ct
        0x1dt
        0x1et
        0x1ft
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        -0x1t
        0xat
        0xbt
        0xct
        0xdt
        0xet
        0xft
        0x10t
        0x11t
        0x12t
        0x13t
        0x14t
        0x15t
        0x16t
        0x17t
        0x18t
        0x19t
        0x1at
        0x1bt
        0x1ct
        0x1dt
        0x1et
        0x1ft
    .end array-data

    :array_4
    .array-data 1
        0x30t
        0x31t
        0x32t
        0x33t
        0x34t
        0x35t
        0x36t
        0x37t
        0x38t
        0x39t
        0x41t
        0x42t
        0x43t
        0x44t
        0x45t
        0x46t
        0x47t
        0x48t
        0x49t
        0x4at
        0x4bt
        0x4ct
        0x4dt
        0x4et
        0x4ft
        0x50t
        0x51t
        0x52t
        0x53t
        0x54t
        0x55t
        0x56t
    .end array-data
.end method

.method public constructor <init>()V
    .locals 1

    const/4 v0, 0x0

    .line 176
    invoke-direct {p0, v0}, Lorg/apache/commons/codec/binary/Base32;-><init>(Z)V

    return-void
.end method

.method public constructor <init>(B)V
    .locals 1

    const/4 v0, 0x0

    .line 187
    invoke-direct {p0, v0, p1}, Lorg/apache/commons/codec/binary/Base32;-><init>(ZB)V

    return-void
.end method

.method public constructor <init>(I)V
    .locals 1

    .line 225
    sget-object v0, Lorg/apache/commons/codec/binary/Base32;->CHUNK_SEPARATOR:[B

    invoke-direct {p0, p1, v0}, Lorg/apache/commons/codec/binary/Base32;-><init>(I[B)V

    return-void
.end method

.method public constructor <init>(I[B)V
    .locals 2

    const/4 v0, 0x0

    const/16 v1, 0x3d

    .line 247
    invoke-direct {p0, p1, p2, v0, v1}, Lorg/apache/commons/codec/binary/Base32;-><init>(I[BZB)V

    return-void
.end method

.method public constructor <init>(I[BZ)V
    .locals 1

    const/16 v0, 0x3d

    .line 272
    invoke-direct {p0, p1, p2, p3, v0}, Lorg/apache/commons/codec/binary/Base32;-><init>(I[BZB)V

    return-void
.end method

.method public constructor <init>(I[BZB)V
    .locals 8

    const/4 v0, 0x0

    if-nez p2, :cond_0

    const/4 v6, 0x0

    goto :goto_0

    .line 298
    :cond_0
    array-length v1, p2

    move v6, v1

    :goto_0
    const/4 v3, 0x5

    const/16 v4, 0x8

    move-object v2, p0

    move v5, p1

    move v7, p4

    invoke-direct/range {v2 .. v7}, Lorg/apache/commons/codec/binary/BaseNCodec;-><init>(IIIIB)V

    if-eqz p3, :cond_1

    .line 301
    sget-object p3, Lorg/apache/commons/codec/binary/Base32;->HEX_ENCODE_TABLE:[B

    iput-object p3, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    .line 302
    sget-object p3, Lorg/apache/commons/codec/binary/Base32;->HEX_DECODE_TABLE:[B

    iput-object p3, p0, Lorg/apache/commons/codec/binary/Base32;->decodeTable:[B

    goto :goto_1

    .line 304
    :cond_1
    sget-object p3, Lorg/apache/commons/codec/binary/Base32;->ENCODE_TABLE:[B

    iput-object p3, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    .line 305
    sget-object p3, Lorg/apache/commons/codec/binary/Base32;->DECODE_TABLE:[B

    iput-object p3, p0, Lorg/apache/commons/codec/binary/Base32;->decodeTable:[B

    :goto_1
    const/16 p3, 0x8

    if-lez p1, :cond_4

    if-eqz p2, :cond_3

    .line 312
    invoke-virtual {p0, p2}, Lorg/apache/commons/codec/binary/Base32;->containsAlphabetOrPad([B)Z

    move-result p1

    if-nez p1, :cond_2

    .line 316
    array-length p1, p2

    add-int/2addr p1, p3

    iput p1, p0, Lorg/apache/commons/codec/binary/Base32;->encodeSize:I

    .line 317
    array-length p1, p2

    new-array p1, p1, [B

    iput-object p1, p0, Lorg/apache/commons/codec/binary/Base32;->lineSeparator:[B

    .line 318
    array-length p3, p2

    invoke-static {p2, v0, p1, v0, p3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_2

    .line 313
    :cond_2
    invoke-static {p2}, Lorg/apache/commons/codec/binary/StringUtils;->newStringUtf8([B)Ljava/lang/String;

    move-result-object p1

    .line 314
    new-instance p2, Ljava/lang/IllegalArgumentException;

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    const-string p4, "lineSeparator must not contain Base32 characters: ["

    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "]"

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p2

    .line 309
    :cond_3
    new-instance p2, Ljava/lang/IllegalArgumentException;

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    const-string p4, "lineLength "

    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p1, " > 0, but lineSeparator is null"

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p2

    .line 320
    :cond_4
    iput p3, p0, Lorg/apache/commons/codec/binary/Base32;->encodeSize:I

    const/4 p1, 0x0

    .line 321
    iput-object p1, p0, Lorg/apache/commons/codec/binary/Base32;->lineSeparator:[B

    .line 323
    :goto_2
    iget p1, p0, Lorg/apache/commons/codec/binary/Base32;->encodeSize:I

    add-int/lit8 p1, p1, -0x1

    iput p1, p0, Lorg/apache/commons/codec/binary/Base32;->decodeSize:I

    .line 325
    invoke-virtual {p0, p4}, Lorg/apache/commons/codec/binary/Base32;->isInAlphabet(B)Z

    move-result p1

    if-nez p1, :cond_5

    invoke-static {p4}, Lorg/apache/commons/codec/binary/Base32;->isWhiteSpace(B)Z

    move-result p1

    if-nez p1, :cond_5

    return-void

    .line 326
    :cond_5
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string p2, "pad must not be in alphabet or whitespace"

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public constructor <init>(Z)V
    .locals 3

    const/4 v0, 0x0

    const/4 v1, 0x0

    const/16 v2, 0x3d

    .line 198
    invoke-direct {p0, v0, v1, p1, v2}, Lorg/apache/commons/codec/binary/Base32;-><init>(I[BZB)V

    return-void
.end method

.method public constructor <init>(ZB)V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x0

    .line 210
    invoke-direct {p0, v0, v1, p1, p2}, Lorg/apache/commons/codec/binary/Base32;-><init>(I[BZB)V

    return-void
.end method

.method private static validateCharacter(JLorg/apache/commons/codec/binary/BaseNCodec$Context;)V
    .locals 2

    .line 576
    iget-wide v0, p2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    and-long/2addr p0, v0

    const-wide/16 v0, 0x0

    cmp-long p2, p0, v0

    if-nez p2, :cond_0

    return-void

    .line 577
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "Last encoded character (before the paddings if any) is a valid base 32 alphabet but not a possible value. Expected the discarded bits to be zero."

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method


# virtual methods
.method decode([BIILorg/apache/commons/codec/binary/BaseNCodec$Context;)V
    .locals 16

    move-object/from16 v0, p0

    move/from16 v1, p3

    move-object/from16 v2, p4

    .line 356
    iget-boolean v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->eof:Z

    if-eqz v3, :cond_0

    return-void

    :cond_0
    const/4 v3, 0x1

    if-gez v1, :cond_1

    .line 360
    iput-boolean v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->eof:Z

    :cond_1
    const/4 v4, 0x0

    move/from16 v4, p2

    const/4 v5, 0x0

    :goto_0
    const/16 v6, 0x18

    const/16 v7, 0x10

    const/16 v8, 0x8

    const-wide/16 v9, 0xff

    if-ge v5, v1, :cond_4

    add-int/lit8 v11, v4, 0x1

    .line 363
    aget-byte v4, p1, v4

    .line 364
    iget-byte v12, v0, Lorg/apache/commons/codec/binary/Base32;->pad:B

    if-ne v4, v12, :cond_2

    .line 366
    iput-boolean v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->eof:Z

    goto :goto_1

    .line 369
    :cond_2
    iget v12, v0, Lorg/apache/commons/codec/binary/Base32;->decodeSize:I

    invoke-virtual {v0, v12, v2}, Lorg/apache/commons/codec/binary/Base32;->ensureBufferSize(ILorg/apache/commons/codec/binary/BaseNCodec$Context;)[B

    move-result-object v12

    if-ltz v4, :cond_3

    .line 370
    iget-object v13, v0, Lorg/apache/commons/codec/binary/Base32;->decodeTable:[B

    array-length v14, v13

    if-ge v4, v14, :cond_3

    .line 371
    aget-byte v4, v13, v4

    if-ltz v4, :cond_3

    .line 373
    iget v13, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->modulus:I

    add-int/2addr v13, v3

    rem-int/2addr v13, v8

    iput v13, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->modulus:I

    .line 375
    iget-wide v13, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/4 v15, 0x5

    shl-long/2addr v13, v15

    int-to-long v3, v4

    add-long/2addr v13, v3

    iput-wide v13, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    .line 376
    iget v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->modulus:I

    if-nez v3, :cond_3

    .line 377
    iget v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v4, v3, 0x1

    iput v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-wide v13, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/16 v4, 0x20

    shr-long/2addr v13, v4

    and-long/2addr v13, v9

    long-to-int v4, v13

    int-to-byte v4, v4

    aput-byte v4, v12, v3

    .line 378
    iget v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v4, v3, 0x1

    iput v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-wide v13, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shr-long/2addr v13, v6

    and-long/2addr v13, v9

    long-to-int v4, v13

    int-to-byte v4, v4

    aput-byte v4, v12, v3

    .line 379
    iget v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v4, v3, 0x1

    iput v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-wide v13, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shr-long v6, v13, v7

    and-long/2addr v6, v9

    long-to-int v4, v6

    int-to-byte v4, v4

    aput-byte v4, v12, v3

    .line 380
    iget v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v4, v3, 0x1

    iput v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-wide v6, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shr-long/2addr v6, v8

    and-long/2addr v6, v9

    long-to-int v4, v6

    int-to-byte v4, v4

    aput-byte v4, v12, v3

    .line 381
    iget v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v4, v3, 0x1

    iput v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-wide v6, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    and-long/2addr v6, v9

    long-to-int v4, v6

    int-to-byte v4, v4

    aput-byte v4, v12, v3

    :cond_3
    add-int/lit8 v5, v5, 0x1

    move v4, v11

    const/4 v3, 0x1

    goto/16 :goto_0

    .line 390
    :cond_4
    :goto_1
    iget-boolean v1, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->eof:Z

    if-eqz v1, :cond_5

    iget v1, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->modulus:I

    const/4 v3, 0x2

    if-lt v1, v3, :cond_5

    .line 391
    iget v1, v0, Lorg/apache/commons/codec/binary/Base32;->decodeSize:I

    invoke-virtual {v0, v1, v2}, Lorg/apache/commons/codec/binary/Base32;->ensureBufferSize(ILorg/apache/commons/codec/binary/BaseNCodec$Context;)[B

    move-result-object v1

    .line 394
    iget v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->modulus:I

    packed-switch v4, :pswitch_data_0

    .line 433
    new-instance v1, Ljava/lang/IllegalStateException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Impossible modulus "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v2, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->modulus:I

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1

    :pswitch_0
    const-wide/16 v3, 0x7

    .line 424
    invoke-static {v3, v4, v2}, Lorg/apache/commons/codec/binary/Base32;->validateCharacter(JLorg/apache/commons/codec/binary/BaseNCodec$Context;)V

    .line 425
    iget-wide v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/4 v5, 0x3

    shr-long/2addr v3, v5

    iput-wide v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    .line 426
    iget v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v4, v3, 0x1

    iput v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-wide v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shr-long/2addr v4, v6

    and-long/2addr v4, v9

    long-to-int v5, v4

    int-to-byte v4, v5

    aput-byte v4, v1, v3

    .line 427
    iget v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v4, v3, 0x1

    iput v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-wide v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shr-long/2addr v4, v7

    and-long/2addr v4, v9

    long-to-int v5, v4

    int-to-byte v4, v5

    aput-byte v4, v1, v3

    .line 428
    iget v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v4, v3, 0x1

    iput v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-wide v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shr-long/2addr v4, v8

    and-long/2addr v4, v9

    long-to-int v5, v4

    int-to-byte v4, v5

    aput-byte v4, v1, v3

    .line 429
    iget v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v4, v3, 0x1

    iput v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-wide v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    and-long/2addr v4, v9

    long-to-int v2, v4

    int-to-byte v2, v2

    aput-byte v2, v1, v3

    goto/16 :goto_2

    :pswitch_1
    const-wide/16 v3, 0x3f

    .line 417
    invoke-static {v3, v4, v2}, Lorg/apache/commons/codec/binary/Base32;->validateCharacter(JLorg/apache/commons/codec/binary/BaseNCodec$Context;)V

    .line 418
    iget-wide v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/4 v5, 0x6

    shr-long/2addr v3, v5

    iput-wide v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    .line 419
    iget v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v4, v3, 0x1

    iput v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-wide v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shr-long/2addr v4, v7

    and-long/2addr v4, v9

    long-to-int v5, v4

    int-to-byte v4, v5

    aput-byte v4, v1, v3

    .line 420
    iget v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v4, v3, 0x1

    iput v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-wide v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shr-long/2addr v4, v8

    and-long/2addr v4, v9

    long-to-int v5, v4

    int-to-byte v4, v5

    aput-byte v4, v1, v3

    .line 421
    iget v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v4, v3, 0x1

    iput v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-wide v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    and-long/2addr v4, v9

    long-to-int v2, v4

    int-to-byte v2, v2

    aput-byte v2, v1, v3

    goto/16 :goto_2

    :pswitch_2
    const-wide/16 v3, 0x1

    .line 410
    invoke-static {v3, v4, v2}, Lorg/apache/commons/codec/binary/Base32;->validateCharacter(JLorg/apache/commons/codec/binary/BaseNCodec$Context;)V

    .line 411
    iget-wide v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/4 v5, 0x1

    shr-long/2addr v3, v5

    iput-wide v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    .line 412
    iget v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v4, v3, 0x1

    iput v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-wide v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shr-long/2addr v4, v7

    and-long/2addr v4, v9

    long-to-int v5, v4

    int-to-byte v4, v5

    aput-byte v4, v1, v3

    .line 413
    iget v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v4, v3, 0x1

    iput v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-wide v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shr-long/2addr v4, v8

    and-long/2addr v4, v9

    long-to-int v5, v4

    int-to-byte v4, v5

    aput-byte v4, v1, v3

    .line 414
    iget v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v4, v3, 0x1

    iput v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-wide v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    and-long/2addr v4, v9

    long-to-int v2, v4

    int-to-byte v2, v2

    aput-byte v2, v1, v3

    goto :goto_2

    :pswitch_3
    const-wide/16 v3, 0xf

    .line 404
    invoke-static {v3, v4, v2}, Lorg/apache/commons/codec/binary/Base32;->validateCharacter(JLorg/apache/commons/codec/binary/BaseNCodec$Context;)V

    .line 405
    iget-wide v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/4 v5, 0x4

    shr-long/2addr v3, v5

    iput-wide v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    .line 406
    iget v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v4, v3, 0x1

    iput v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-wide v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shr-long/2addr v4, v8

    and-long/2addr v4, v9

    long-to-int v5, v4

    int-to-byte v4, v5

    aput-byte v4, v1, v3

    .line 407
    iget v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v4, v3, 0x1

    iput v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-wide v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    and-long/2addr v4, v9

    long-to-int v2, v4

    int-to-byte v2, v2

    aput-byte v2, v1, v3

    goto :goto_2

    :pswitch_4
    const-wide/16 v3, 0x7f

    .line 400
    invoke-static {v3, v4, v2}, Lorg/apache/commons/codec/binary/Base32;->validateCharacter(JLorg/apache/commons/codec/binary/BaseNCodec$Context;)V

    .line 401
    iget v3, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v4, v3, 0x1

    iput v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-wide v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/4 v2, 0x7

    shr-long/2addr v4, v2

    and-long/2addr v4, v9

    long-to-int v2, v4

    int-to-byte v2, v2

    aput-byte v2, v1, v3

    goto :goto_2

    :pswitch_5
    const-wide/16 v4, 0x3

    .line 396
    invoke-static {v4, v5, v2}, Lorg/apache/commons/codec/binary/Base32;->validateCharacter(JLorg/apache/commons/codec/binary/BaseNCodec$Context;)V

    .line 397
    iget v4, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v5, v4, 0x1

    iput v5, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-wide v5, v2, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shr-long v2, v5, v3

    and-long/2addr v2, v9

    long-to-int v3, v2

    int-to-byte v2, v3

    aput-byte v2, v1, v4

    :cond_5
    :goto_2
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method encode([BIILorg/apache/commons/codec/binary/BaseNCodec$Context;)V
    .locals 11

    .line 457
    iget-boolean v0, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->eof:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    const/4 v1, 0x1

    if-gez p3, :cond_7

    .line 463
    iput-boolean v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->eof:Z

    .line 464
    iget p1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->modulus:I

    if-nez p1, :cond_1

    iget p1, p0, Lorg/apache/commons/codec/binary/Base32;->lineLength:I

    if-nez p1, :cond_1

    return-void

    .line 467
    :cond_1
    iget p1, p0, Lorg/apache/commons/codec/binary/Base32;->encodeSize:I

    invoke-virtual {p0, p1, p4}, Lorg/apache/commons/codec/binary/Base32;->ensureBufferSize(ILorg/apache/commons/codec/binary/BaseNCodec$Context;)[B

    move-result-object p1

    .line 468
    iget p2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    .line 469
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->modulus:I

    if-eqz p3, :cond_6

    const/4 v2, 0x3

    const/4 v3, 0x2

    if-eq p3, v1, :cond_5

    const/4 v4, 0x4

    if-eq p3, v3, :cond_4

    if-eq p3, v2, :cond_3

    if-ne p3, v4, :cond_2

    .line 503
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v1, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v4, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/16 v6, 0x1b

    shr-long/2addr v4, v6

    long-to-int v5, v4

    and-int/lit8 v4, v5, 0x1f

    aget-byte v1, v1, v4

    aput-byte v1, p1, p3

    .line 504
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v1, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v4, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/16 v6, 0x16

    shr-long/2addr v4, v6

    long-to-int v5, v4

    and-int/lit8 v4, v5, 0x1f

    aget-byte v1, v1, v4

    aput-byte v1, p1, p3

    .line 505
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v1, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v4, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/16 v6, 0x11

    shr-long/2addr v4, v6

    long-to-int v5, v4

    and-int/lit8 v4, v5, 0x1f

    aget-byte v1, v1, v4

    aput-byte v1, p1, p3

    .line 506
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v1, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v4, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/16 v6, 0xc

    shr-long/2addr v4, v6

    long-to-int v5, v4

    and-int/lit8 v4, v5, 0x1f

    aget-byte v1, v1, v4

    aput-byte v1, p1, p3

    .line 507
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v1, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v4, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/4 v6, 0x7

    shr-long/2addr v4, v6

    long-to-int v5, v4

    and-int/lit8 v4, v5, 0x1f

    aget-byte v1, v1, v4

    aput-byte v1, p1, p3

    .line 508
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v1, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v4, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shr-long v3, v4, v3

    long-to-int v4, v3

    and-int/lit8 v3, v4, 0x1f

    aget-byte v1, v1, v3

    aput-byte v1, p1, p3

    .line 509
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v1, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shl-long v2, v3, v2

    long-to-int v3, v2

    and-int/lit8 v2, v3, 0x1f

    aget-byte v1, v1, v2

    aput-byte v1, p1, p3

    .line 510
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-byte v1, p0, Lorg/apache/commons/codec/binary/Base32;->pad:B

    aput-byte v1, p1, p3

    goto/16 :goto_0

    .line 513
    :cond_2
    new-instance p1, Ljava/lang/IllegalStateException;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "Impossible modulus "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->modulus:I

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 493
    :cond_3
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v2, p3, 0x1

    iput v2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v2, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v5, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/16 v3, 0x13

    shr-long/2addr v5, v3

    long-to-int v3, v5

    and-int/lit8 v3, v3, 0x1f

    aget-byte v2, v2, v3

    aput-byte v2, p1, p3

    .line 494
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v2, p3, 0x1

    iput v2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v2, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v5, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/16 v3, 0xe

    shr-long/2addr v5, v3

    long-to-int v3, v5

    and-int/lit8 v3, v3, 0x1f

    aget-byte v2, v2, v3

    aput-byte v2, p1, p3

    .line 495
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v2, p3, 0x1

    iput v2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v2, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v5, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/16 v3, 0x9

    shr-long/2addr v5, v3

    long-to-int v3, v5

    and-int/lit8 v3, v3, 0x1f

    aget-byte v2, v2, v3

    aput-byte v2, p1, p3

    .line 496
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v2, p3, 0x1

    iput v2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v2, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v5, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shr-long v3, v5, v4

    long-to-int v4, v3

    and-int/lit8 v3, v4, 0x1f

    aget-byte v2, v2, v3

    aput-byte v2, p1, p3

    .line 497
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v2, p3, 0x1

    iput v2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v2, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shl-long/2addr v3, v1

    long-to-int v1, v3

    and-int/lit8 v1, v1, 0x1f

    aget-byte v1, v2, v1

    aput-byte v1, p1, p3

    .line 498
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-byte v1, p0, Lorg/apache/commons/codec/binary/Base32;->pad:B

    aput-byte v1, p1, p3

    .line 499
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-byte v1, p0, Lorg/apache/commons/codec/binary/Base32;->pad:B

    aput-byte v1, p1, p3

    .line 500
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-byte v1, p0, Lorg/apache/commons/codec/binary/Base32;->pad:B

    aput-byte v1, p1, p3

    goto/16 :goto_0

    .line 483
    :cond_4
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v2, p3, 0x1

    iput v2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v2, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v5, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/16 v3, 0xb

    shr-long/2addr v5, v3

    long-to-int v3, v5

    and-int/lit8 v3, v3, 0x1f

    aget-byte v2, v2, v3

    aput-byte v2, p1, p3

    .line 484
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v2, p3, 0x1

    iput v2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v2, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v5, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/4 v3, 0x6

    shr-long/2addr v5, v3

    long-to-int v3, v5

    and-int/lit8 v3, v3, 0x1f

    aget-byte v2, v2, v3

    aput-byte v2, p1, p3

    .line 485
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v2, p3, 0x1

    iput v2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v2, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v5, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shr-long/2addr v5, v1

    long-to-int v1, v5

    and-int/lit8 v1, v1, 0x1f

    aget-byte v1, v2, v1

    aput-byte v1, p1, p3

    .line 486
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v1, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shl-long/2addr v2, v4

    long-to-int v3, v2

    and-int/lit8 v2, v3, 0x1f

    aget-byte v1, v1, v2

    aput-byte v1, p1, p3

    .line 487
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-byte v1, p0, Lorg/apache/commons/codec/binary/Base32;->pad:B

    aput-byte v1, p1, p3

    .line 488
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-byte v1, p0, Lorg/apache/commons/codec/binary/Base32;->pad:B

    aput-byte v1, p1, p3

    .line 489
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-byte v1, p0, Lorg/apache/commons/codec/binary/Base32;->pad:B

    aput-byte v1, p1, p3

    .line 490
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-byte v1, p0, Lorg/apache/commons/codec/binary/Base32;->pad:B

    aput-byte v1, p1, p3

    goto :goto_0

    .line 473
    :cond_5
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v1, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v4, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shr-long/2addr v4, v2

    long-to-int v2, v4

    and-int/lit8 v2, v2, 0x1f

    aget-byte v1, v1, v2

    aput-byte v1, p1, p3

    .line 474
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v1, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v4, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shl-long v2, v4, v3

    long-to-int v3, v2

    and-int/lit8 v2, v3, 0x1f

    aget-byte v1, v1, v2

    aput-byte v1, p1, p3

    .line 475
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-byte v1, p0, Lorg/apache/commons/codec/binary/Base32;->pad:B

    aput-byte v1, p1, p3

    .line 476
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-byte v1, p0, Lorg/apache/commons/codec/binary/Base32;->pad:B

    aput-byte v1, p1, p3

    .line 477
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-byte v1, p0, Lorg/apache/commons/codec/binary/Base32;->pad:B

    aput-byte v1, p1, p3

    .line 478
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-byte v1, p0, Lorg/apache/commons/codec/binary/Base32;->pad:B

    aput-byte v1, p1, p3

    .line 479
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-byte v1, p0, Lorg/apache/commons/codec/binary/Base32;->pad:B

    aput-byte v1, p1, p3

    .line 480
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v1, p3, 0x1

    iput v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-byte v1, p0, Lorg/apache/commons/codec/binary/Base32;->pad:B

    aput-byte v1, p1, p3

    .line 515
    :cond_6
    :goto_0
    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->currentLinePos:I

    iget v1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    sub-int/2addr v1, p2

    add-int/2addr p3, v1

    iput p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->currentLinePos:I

    .line 517
    iget p2, p0, Lorg/apache/commons/codec/binary/Base32;->lineLength:I

    if-lez p2, :cond_a

    iget p2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->currentLinePos:I

    if-lez p2, :cond_a

    .line 518
    iget-object p2, p0, Lorg/apache/commons/codec/binary/Base32;->lineSeparator:[B

    iget p3, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v1, p0, Lorg/apache/commons/codec/binary/Base32;->lineSeparator:[B

    array-length v1, v1

    invoke-static {p2, v0, p1, p3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 519
    iget p1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object p2, p0, Lorg/apache/commons/codec/binary/Base32;->lineSeparator:[B

    array-length p2, p2

    add-int/2addr p1, p2

    iput p1, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    goto/16 :goto_2

    :cond_7
    const/4 v2, 0x0

    :goto_1
    if-ge v2, p3, :cond_a

    .line 523
    iget v3, p0, Lorg/apache/commons/codec/binary/Base32;->encodeSize:I

    invoke-virtual {p0, v3, p4}, Lorg/apache/commons/codec/binary/Base32;->ensureBufferSize(ILorg/apache/commons/codec/binary/BaseNCodec$Context;)[B

    move-result-object v3

    .line 524
    iget v4, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->modulus:I

    add-int/2addr v4, v1

    const/4 v5, 0x5

    rem-int/2addr v4, v5

    iput v4, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->modulus:I

    add-int/lit8 v4, p2, 0x1

    .line 525
    aget-byte p2, p1, p2

    if-gez p2, :cond_8

    add-int/lit16 p2, p2, 0x100

    .line 529
    :cond_8
    iget-wide v6, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/16 v8, 0x8

    shl-long/2addr v6, v8

    int-to-long v9, p2

    add-long/2addr v6, v9

    iput-wide v6, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    .line 530
    iget p2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->modulus:I

    if-nez p2, :cond_9

    .line 531
    iget p2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v6, p2, 0x1

    iput v6, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v6, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v9, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/16 v7, 0x23

    shr-long/2addr v9, v7

    long-to-int v7, v9

    and-int/lit8 v7, v7, 0x1f

    aget-byte v6, v6, v7

    aput-byte v6, v3, p2

    .line 532
    iget p2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v6, p2, 0x1

    iput v6, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v6, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v9, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/16 v7, 0x1e

    shr-long/2addr v9, v7

    long-to-int v7, v9

    and-int/lit8 v7, v7, 0x1f

    aget-byte v6, v6, v7

    aput-byte v6, v3, p2

    .line 533
    iget p2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v6, p2, 0x1

    iput v6, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v6, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v9, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/16 v7, 0x19

    shr-long/2addr v9, v7

    long-to-int v7, v9

    and-int/lit8 v7, v7, 0x1f

    aget-byte v6, v6, v7

    aput-byte v6, v3, p2

    .line 534
    iget p2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v6, p2, 0x1

    iput v6, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v6, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v9, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/16 v7, 0x14

    shr-long/2addr v9, v7

    long-to-int v7, v9

    and-int/lit8 v7, v7, 0x1f

    aget-byte v6, v6, v7

    aput-byte v6, v3, p2

    .line 535
    iget p2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v6, p2, 0x1

    iput v6, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v6, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v9, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/16 v7, 0xf

    shr-long/2addr v9, v7

    long-to-int v7, v9

    and-int/lit8 v7, v7, 0x1f

    aget-byte v6, v6, v7

    aput-byte v6, v3, p2

    .line 536
    iget p2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v6, p2, 0x1

    iput v6, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v6, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v9, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    const/16 v7, 0xa

    shr-long/2addr v9, v7

    long-to-int v7, v9

    and-int/lit8 v7, v7, 0x1f

    aget-byte v6, v6, v7

    aput-byte v6, v3, p2

    .line 537
    iget p2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v6, p2, 0x1

    iput v6, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v6, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v9, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    shr-long/2addr v9, v5

    long-to-int v5, v9

    and-int/lit8 v5, v5, 0x1f

    aget-byte v5, v6, v5

    aput-byte v5, v3, p2

    .line 538
    iget p2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    add-int/lit8 v5, p2, 0x1

    iput v5, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v5, p0, Lorg/apache/commons/codec/binary/Base32;->encodeTable:[B

    iget-wide v6, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->lbitWorkArea:J

    long-to-int v7, v6

    and-int/lit8 v6, v7, 0x1f

    aget-byte v5, v5, v6

    aput-byte v5, v3, p2

    .line 539
    iget p2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->currentLinePos:I

    add-int/2addr p2, v8

    iput p2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->currentLinePos:I

    .line 540
    iget p2, p0, Lorg/apache/commons/codec/binary/Base32;->lineLength:I

    if-lez p2, :cond_9

    iget p2, p0, Lorg/apache/commons/codec/binary/Base32;->lineLength:I

    iget v5, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->currentLinePos:I

    if-gt p2, v5, :cond_9

    .line 541
    iget-object p2, p0, Lorg/apache/commons/codec/binary/Base32;->lineSeparator:[B

    iget v5, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v6, p0, Lorg/apache/commons/codec/binary/Base32;->lineSeparator:[B

    array-length v6, v6

    invoke-static {p2, v0, v3, v5, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 542
    iget p2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    iget-object v3, p0, Lorg/apache/commons/codec/binary/Base32;->lineSeparator:[B

    array-length v3, v3

    add-int/2addr p2, v3

    iput p2, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->pos:I

    .line 543
    iput v0, p4, Lorg/apache/commons/codec/binary/BaseNCodec$Context;->currentLinePos:I

    :cond_9
    add-int/lit8 v2, v2, 0x1

    move p2, v4

    goto/16 :goto_1

    :cond_a
    :goto_2
    return-void
.end method

.method public isInAlphabet(B)Z
    .locals 2

    if-ltz p1, :cond_0

    .line 559
    iget-object v0, p0, Lorg/apache/commons/codec/binary/Base32;->decodeTable:[B

    array-length v1, v0

    if-ge p1, v1, :cond_0

    aget-byte p1, v0, p1

    const/4 v0, -0x1

    if-eq p1, v0, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method
