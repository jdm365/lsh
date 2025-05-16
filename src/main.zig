const std = @import("std");


inline fn shingleMinHash(
    str: []const u8, 
    min_ngram_size: usize,
    max_ngram_size: usize,
) u64 {
    var min_val: u64 = comptime std.math.maxInt(u64);
    for (min_ngram_size..max_ngram_size) |ngram_size| {
        for (0..str.len - ngram_size) |idx| {
            const ngram = str[idx..idx + ngram_size];
            const hash = std.hash.XxHash64.hash(42, ngram);
            min_val = @min(min_val, hash);
        }
    }

    return min_val;
}

pub fn main() !void {
    const _test = "hello world";

    const hashed = std.hash.XxHash64.hash(42, _test);

    std.debug.print("Hash of '{s}': {d}\n", .{_test, hashed});

    const min_ngram_size = 1;
    const max_ngram_size = 3;

    var signature: [16]u64 = undefined;

    for (0..signature.len) |i| {
        signature[i] = shingleMinHash(_test, min_ngram_size, max_ngram_size);
    }
}

