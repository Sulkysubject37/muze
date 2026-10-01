const std = @import("std");
const Kind = @import("kinds.zig").Kind;
const Lang = @import("kinds.zig").Lang;

pub const NIL: u32 = 0xFFFFFFFF;

pub const IR = struct {
    arena: std.heap.ArenaAllocator,

    kind:        []Kind,
    start:       []u32,
    end:         []u32,
    parent:      []u32,
    first_child: []u32,
    child_count: []u32,
    lang:        []Lang,

    op_start:    []u32,
    op_end:      []u32,

    src:         []const u8,
    n:           usize,

    // Capacity-tracking arrays (private).
    cap:         usize,

    pub fn init(arena: *std.heap.ArenaAllocator, src: []const u8, cap: usize) !IR {
        const a = arena.allocator();
        return .{
            .arena = arena.*,
            .kind        = try a.alloc(Kind, cap),
            .start       = try a.alloc(u32, cap),
            .end         = try a.alloc(u32, cap),
            .parent      = try a.alloc(u32, cap),
            .first_child = try a.alloc(u32, cap),
            .child_count = try a.alloc(u32, cap),
            .lang        = try a.alloc(Lang, cap),
            .op_start    = try a.alloc(u32, cap),
            .op_end      = try a.alloc(u32, cap),
            .src         = src,
            .n           = 0,
            .cap         = cap,
        };
    }

    pub fn append(
        self: *IR,
        k: Kind,
        s: u32,
        e: u32,
        l: Lang,
        parent_idx: u32,
    ) !u32 {
        if (self.n >= self.cap) return error.IRCapacityExceeded;
        const i: u32 = @intCast(self.n);
        self.kind[i]        = k;
        self.start[i]       = s;
        self.end[i]         = e;
        self.lang[i]        = l;
        self.parent[i]      = parent_idx;
        self.first_child[i] = NIL;
        self.child_count[i] = 0;
        self.op_start[i]    = 0;
        self.op_end[i]      = 0;
        self.n += 1;

        if (parent_idx != NIL) {
            if (self.first_child[parent_idx] == NIL) {
                self.first_child[parent_idx] = i;
            }
            self.child_count[parent_idx] += 1;
        }
        return i;
    }

    pub fn setOpRange(self: *IR, idx: u32, s: u32, e: u32) void {
        self.op_start[idx] = s;
        self.op_end[idx]   = e;
    }

    pub fn opSlice(self: *const IR, idx: u32) []const u8 {
        return self.src[self.op_start[idx]..self.op_end[idx]];
    }

    pub fn nodeSlice(self: *const IR, idx: u32) []const u8 {
        return self.src[self.start[idx]..self.end[idx]];
    }

    pub fn nthChild(self: *const IR, idx: u32, nth: u32) u32 {
        if (idx == NIL) return NIL;
        if (nth >= self.child_count[idx]) return NIL;
        const first = self.first_child[idx];
        if (first == NIL) return NIL;
        return first + nth;
    }
};
