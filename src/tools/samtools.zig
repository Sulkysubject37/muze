const Lang = @import("../ir/kinds.zig").Lang;
const Adapter = @import("../runner/adapter.zig").Adapter;

pub const adapter = Adapter{
    .name = "samtools",
    .source_root = "external/samtools",
    .lang = .c,
    .extensions = &.{ ".c" },
    .source_dirs = &.{ 
        "sam_view.c", "bam_md.c", "bam_sort.c", "bam_index.c", 
        "bam_plcmd.c", "faidx.c", "bam_aux.c", "bam.c", 
        "sam_opts.c", "sam_utils.c", "bam_import.c", "bedidx.c", 
        "bam_rmdup.c", "bam_reheader.c", "bam_stat.c" 
    },
    .skip_dirs = &.{ "test", "tests" },
    .build_cmd = "make -j4 samtools",
    .test_cmd = "make test",
    .build_timeout_s = 600,
    .test_timeout_s = 900,
    .smoke_cmd = "./samtools --version",
};
