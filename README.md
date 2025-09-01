# compress

Zig compression library originally ported from stdlib 0.14.1, to work with the
new IO interface introduced in 0.15.1.

## Progress

Currently the following areas are passing tests:

| Namespace | Compression Tests Passing | Decompression Tests Passing | 
| --------- | ------------------------- | --------------------------- |
| gzip      | Yes                       | No                          | 
| lzma      | No                        | No                          | 
| lzma2     | No                        | No                          | 
| xz        | No                        | No                          | 
| flate     | No                        | No                          | 
| zlib      | No                        | No                          | 
| zstd      | No                        | No                          | 
