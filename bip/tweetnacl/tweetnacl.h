#pragma once

/* the original file seems to be a compability layer for NaCL */
/* This here is for direct tweetnacl usage */

#ifdef __cplusplus
#include <cstdint>
#else
#include <stdint.h>
#endif

typedef uint8_t  u8;
typedef uint32_t u32;
typedef uint64_t u64;
typedef int64_t  i64;
typedef i64 gf[16];


#define crypto_box_SECRETKEYBYTES 32
#define crypto_box_BOXZEROBYTES 16
#define crypto_box_NONCEBYTES 24
#define crypto_box_ZEROBYTES 32
#define crypto_box_PUBLICKEYBYTES 32
#define crypto_box_BEFORENMBYTES 32
#define crypto_secretbox_KEYBYTES 32
#define crypto_secretbox_NONCEBYTES 24
#define crypto_secretbox_ZEROBYTES 32
#define crypto_secretbox_BOXZEROBYTES 16

#ifdef __cplusplus
extern "C" {
#endif

int crypto_box_keypair(u8 *y,u8 *x);
int crypto_box_afternm(u8 *c,const u8 *m,u64 d,const u8 *n,const u8 *k);


int crypto_box_open_afternm(u8 *m,const u8 *c,u64 d,const u8 *n,const u8 *k);
int crypto_box(u8 *c,const u8 *m,u64 d,const u8 *n,const u8 *y,const u8 *x);
int crypto_box_open(u8 *m,const u8 *c,u64 d,const u8 *n,const u8 *y,const u8 *x);
int crypto_box_beforenm(u8 *k,const u8 *y,const u8 *x);
int crypto_secretbox(u8 *c,const u8 *m,u64 d,const u8 *n,const u8 *k);
int crypto_secretbox_open(u8 *m,const u8 *c,u64 d,const u8 *n,const u8 *k);

#ifdef __cplusplus
}
#endif


