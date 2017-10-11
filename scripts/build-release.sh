echo "Building pet_store_build:0.1${BUILDKITE_COMMIT}"
mix docker.build --tag pet_store_build:0.1${BUILDKITE_COMMIT} &&
  mix docker.release --tag pet_store:0.1${BUILDKITE_COMMIT}
