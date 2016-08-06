LIBCOMM="libcomm/comm/c_api/target/x86_64-apple-ios/debug/libcomm.a"

$(LIBCOMM):
	cargo build --manifest-path libcomm/comm/c_api/Cargo.toml --target x86_64-apple-ios

libcomm: $(LIBCOMM)
.PHONY: libcomm

test: $(LIBCOMM)
	xcodebuild test -scheme Comm -destination 'name=iPhone 6s'
.PHONY: test
