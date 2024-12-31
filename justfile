default:
    just --list --unsorted

run:
    zig build run

test:
    zig build test