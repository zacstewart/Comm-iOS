ARCHS=i386-apple-ios x86_64-apple-ios armv7-apple-ios armv7s-apple-ios aarch64-apple-ios
FATLIB=Comm/libcomm/comm/c_api/target/fat-apple-ios/debug/libcomm.a
PREFIX=Comm/libcomm/comm/c_api/target/
SUFFIX=/debug/libcomm.a
CARGO=cargo
LIBS=$(addprefix $(PREFIX), $(addsuffix $(SUFFIX), $(ARCHS)))

libcomm: $(FATLIB)
.PHONY: libcomm

$(FATLIB): $(LIBS)
	mkdir -p Comm/libcomm/comm/c_api/target/fat-apple-ios/debug
	lipo -create $(LIBS) -output $(FATLIB)

$(PREFIX)%$(SUFFIX):
	$(CARGO) build --manifest-path Comm/libcomm/comm/c_api/Cargo.toml --target $*

clean:
	$(CARGO) clean --manifest-path Comm/libcomm/comm/c_api/Cargo.toml
	xcodebuild clean
.PHONY: clean

test: libcomm
	xcodebuild test -scheme Comm -destination 'name=iPhone 6s'
.PHONY: test
