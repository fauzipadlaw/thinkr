# Cache Optimization for GitHub Actions Runners

## Overview
This document describes the cache optimization strategies implemented in the GitHub Actions workflows to improve build performance.

## Implemented Caches

### 1. Flutter SDK Cache
- **Location**: Managed by `subosito/flutter-action@v2`
- **Configuration**: `cache: true`
- **Purpose**: Caches the Flutter SDK installation
- **Applied to**: All workflows (CI, Release)

### 2. Pub Dependencies Cache
- **Path**: `~/.pub-cache`
- **Key**: `${{ runner.os }}-pub-${{ hashFiles('**/pubspec.lock') }}`
- **Purpose**: Caches Dart/Flutter package dependencies
- **Applied to**: All workflows (CI, Release)
- **Benefit**: Avoids re-downloading packages on every build

### 3. Dart Tool Cache
- **Path**: `.dart_tool`
- **Key**: `${{ runner.os }}-dart-tool-${{ hashFiles('**/pubspec.lock') }}`
- **Purpose**: Caches Dart analysis and build artifacts
- **Applied to**: All workflows (CI, Release)
- **Benefit**: Speeds up analysis and incremental builds

### 4. Gradle Cache (Android)
- **Paths**:
  - `~/.gradle/caches`
  - `~/.gradle/wrapper`
  - `~/.android/build-cache`
- **Key**: `${{ runner.os }}-gradle-${{ hashFiles('**/*.gradle*', '**/gradle-wrapper.properties') }}`
- **Purpose**: Caches Gradle dependencies and build cache
- **Applied to**: CI (build_check), Release
- **Benefit**: Significantly reduces Android build times (can save 2-5 minutes per build)

### 5. CocoaPods Cache (iOS)
- **Paths**:
  - `ios/Pods`
  - `~/Library/Caches/CocoaPods`
  - `~/.cocoapods`
- **Key**: `${{ runner.os }}-pods-${{ hashFiles('**/Podfile.lock') }}`
- **Purpose**: Caches iOS dependencies
- **Applied to**: CI (build_check), Release
- **Benefit**: Reduces iOS build times by avoiding pod installation (can save 1-3 minutes per build)

## Workflow-Specific Implementation

### CI Workflow (.github/workflows/ci.yml)

#### Test Job
- Flutter SDK cache
- Pub dependencies cache
- Dart tool cache

#### Build Check Job
- Flutter SDK cache
- Pub dependencies cache
- Dart tool cache
- Gradle cache
- CocoaPods cache

### Release Workflow (.github/workflows/release.yml)

#### Build and Release Job
- Flutter SDK cache
- Pub dependencies cache
- Dart tool cache
- Gradle cache
- CocoaPods cache

## Expected Performance Improvements

### First Run (Cold Cache)
- No improvement - caches need to be populated

### Subsequent Runs (Warm Cache)
- **Pub dependencies**: ~30-60 seconds saved
- **Dart tool**: ~10-20 seconds saved
- **Gradle (Android)**: ~2-5 minutes saved
- **CocoaPods (iOS)**: ~1-3 minutes saved
- **Total estimated savings**: ~4-9 minutes per build

## Cache Invalidation

Caches are automatically invalidated when:
- `pubspec.lock` changes (Pub, Dart tool)
- Gradle files change (Gradle)
- `Podfile.lock` changes (CocoaPods)

## Monitoring Cache Performance

To monitor cache effectiveness:
1. Check workflow logs for "Cache restored" messages
2. Compare build times before and after cache implementation
3. Monitor cache hit rates in Actions tab

## Best Practices

1. **Keep dependencies stable**: Frequent dependency updates will invalidate caches
2. **Use lock files**: Always commit `pubspec.lock` and `Podfile.lock`
3. **Monitor cache size**: GitHub has a 10GB cache limit per repository
4. **Clean old caches**: GitHub automatically removes caches not accessed in 7 days

## Troubleshooting

### Cache Not Restoring
- Verify the cache key matches between save and restore
- Check if the cache was created in a previous run
- Ensure file paths are correct for the runner OS

### Build Still Slow
- Check if cache is being hit (look for "Cache restored" in logs)
- Verify all necessary paths are included in cache configuration
- Consider if other bottlenecks exist (network, CPU, etc.)

### Cache Size Issues
- Monitor total cache size in repository settings
- Consider excluding large unnecessary files
- Use more specific cache keys to avoid storing duplicates

## Future Optimizations

Potential future improvements:
- Add build output caching for incremental builds
- Implement cache warming strategies
- Add cache analytics and monitoring
- Consider using custom cache solutions for very large projects

## References

- [GitHub Actions Cache Documentation](https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows)
- [Flutter CI/CD Best Practices](https://docs.flutter.dev/deployment/cd)
- [Gradle Build Cache](https://docs.gradle.org/current/userguide/build_cache.html)
- [CocoaPods Installation](https://guides.cocoapods.org/using/getting-started.html)
