pub const Verdict = enum {
    killed,
    survived,
    invalid,
    timeout,
};

pub const Category = enum {
    strong_kill,
    silent_to_tests,
    assertion_only,
    full_escape,
    invalid,
};
