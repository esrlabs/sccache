set -ex

src=$(pwd)
stage=
case $TRAVIS_OS_NAME in
    linux)
        stage=$(mktemp -d)
        cross build --target $TARGET --release --features redis --no-default-features
        cp target/$TARGET/release/sccache $stage/
        ;;
    osx)
        stage=$(mktemp -d -t tmp)
        cargo build --target $TARGET --release --features redis --no-default-features
        cp target/$TARGET/release/sccache $stage/
        ;;
    windows)
        stage=$(mktemp -d)
        cargo build --target $TARGET --release --features redis --no-default-features
        cp target/$TARGET/release/sccache.exe $stage/
        ;;
esac

cd $stage
tar czf $src/$CRATE_NAME-$TRAVIS_TAG-$TARGET.tar.gz *
cd $src

rm -rf $stage
