//! Compression algorithms.

const std = @import("std");

pub const flate = @import("flate.zig");
pub const gzip = @import("gzip.zig");
pub const zlib = @import("zlib.zig");
pub const lzma = @import("lzma.zig");
pub const lzma2 = @import("lzma2.zig");
pub const xz = @import("xz.zig");
pub const zstd = @import("zstandard.zig");

pub fn HashedReader(ReaderType: type, HasherType: type) type {
    return struct {
        child_reader: ReaderType,
        hasher: HasherType,

        pub const Error = ReaderType.Error;
        pub const Reader = std.io.Reader(*@This(), Error, read);

        pub fn read(self: *@This(), buf: []u8) Error!usize {
            const amt = try self.child_reader.read(buf);
            self.hasher.update(buf[0..amt]);
            return amt;
        }

        pub fn reader(self: *@This()) Reader {
            return .{ .context = self };
        }
    };
}

pub fn hashedReader(
    reader: *std.Io.Reader,
    hasher: anytype,
) HashedReader(@TypeOf(reader), @TypeOf(hasher)) {
    return .{ .child_reader = reader, .hasher = hasher };
}

pub fn HashedWriter(WriterType: type, HasherType: type) type {
    return struct {
        child_writer: WriterType,
        hasher: HasherType,

        pub const Error = WriterType.Error;
        pub const Writer = std.io.Writer(*@This(), Error, write);

        pub fn write(self: *@This(), buf: []const u8) Error!usize {
            const amt = try self.child_writer.write(buf);
            self.hasher.update(buf[0..amt]);
            return amt;
        }

        pub fn writer(self: *@This()) Writer {
            return .{ .context = self };
        }
    };
}

pub fn hashedWriter(
    writer: *std.Io.Writer,
    hasher: anytype,
) HashedWriter(@TypeOf(writer), @TypeOf(hasher)) {
    return .{ .child_writer = writer, .hasher = hasher };
}

test {
    //_ = lzma;
    //_ = lzma2;
    //_ = xz;
    //_ = zstd;
    //_ = flate;
    _ = gzip;
    //_ = zlib;
    _ = @import("legacy_bit_reader.zig");
}
