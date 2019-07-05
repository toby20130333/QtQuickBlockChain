#pragma once

#include <cstdint>

typedef uint8_t  u8;
typedef uint32_t u32;
typedef uint64_t u64;
typedef int64_t  i64;


template<class T, int N>
struct crypto_array;


template<class T>
struct crypto_array<T, 0>
{
    crypto_array() {}
    crypto_array(T* t, u64 s) : p(t), n(s) {}

    T*const p = nullptr;
    u64 n = 0;

    T& operator[](u64 i)       { return p[i]; }
    T  operator[](u64 i) const { return p[i]; }

    const crypto_array operator+(int i) const { return crypto_array(p + i, n - i);  }
};


template<class T, int N>
struct crypto_array
{
    enum { Size = N };

    crypto_array() : ptr(data) {}
    template<int M>
    crypto_array(const crypto_array<T,M> rhs) : ptr(const_cast<crypto_array<T,M>*>(&rhs)->p()) { static_assert(M >= N, "could not downgrade"); }

    T& operator[](int i)       { return ptr[i]; }
    T  operator[](int i) const { return ptr[i];  }

    const crypto_array operator+(int i) const { return crypto_array(ptr + i);  }

    T* p() { return &ptr[0]; }
    crypto_array<T,0> t0() const { return crypto_array<T,0>(ptr, N); }
    static crypto_array wrap(const T* ptr) { return crypto_array(const_cast<T*>(ptr)); }

private:
    crypto_array(T* ptr) : ptr(ptr) {}
    T data[N] = {0};
    T*const ptr;
};


typedef crypto_array<u8, 0> Message;
typedef crypto_array<u8, 32> Key;
typedef crypto_array<u8, 24> Nonce;


int crypto_box_keypair      (Key *pk, Key *sk);
int crypto_box_afternm      (Message &c, const Message &m, const Nonce &n, const Key &k);
int crypto_box_open_afternm (Message &m, const Message &c, const Nonce &n, const Key &k);
int crypto_box              (Message &c, const Message &m, const Nonce &n, const Key &y, const Key &x);
int crypto_box_open         (Message &m, const Message &c, const Nonce &n, const Key &y, const Key &x);
int crypto_box_beforenm     (Key &k, const Key &y, const Key &x);
int crypto_secretbox        (Message &c, const Message &m, const Nonce &n, const Key &k);
int crypto_secretbox_open   (Message &m, const Message &c, const Nonce &n, const Key &k);



