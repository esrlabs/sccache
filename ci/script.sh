set -ex

if [ -z $TRAVIS_TAG ]; then
    case $TRAVIS_OS_NAME in
        linux)
            cross build --target $TARGET --features redis --no-default-features
            ;;
        osx)
            cargo build --target $TARGET --features redis --no-default-features
            ;;
        windows)
            cargo build --target $TARGET --features redis --no-default-features
            ;;
    esac
fi
