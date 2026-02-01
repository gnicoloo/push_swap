# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-02-01

### Added
- 📁 **Professional project structure**
  - Organized source files in `src/` directory
  - Moved headers to `include/` directory
  - Created `obj/` directory for object files
  
- 📚 **Comprehensive documentation**
  - Complete README.md with badges, usage examples, and performance benchmarks
  - Detailed ALGORITHM.md explaining the chunk-based sorting strategy
  - CONTRIBUTING.md with guidelines for contributors
  - LICENSE file (MIT)
  - This CHANGELOG

- 🧪 **Testing infrastructure**
  - Professional test.sh script with colored output
  - Error handling tests
  - Identity tests (already sorted)
  - Performance tests (100 and 500 numbers)
  - Benchmarking capabilities

- 🔧 **Enhanced Makefile**
  - Colored output for better readability
  - Separate object directory
  - Built-in test targets (`make test100`, `make test500`, etc.)
  - Benchmark target (`make bench`)
  - Help target (`make help`)
  - Cleaner compilation output

- 📝 **Better .gitignore**
  - Comprehensive ignore rules
  - Covers executables, object files, editor files, test results

### Changed
- 🏗️ **Code organization**
  - Restructured from flat directory to organized hierarchy
  - Updated include paths in header files
  - Improved Makefile with modern best practices

### Performance
- Current benchmarks:
  - 3 numbers: ≤ 3 operations
  - 5 numbers: ≤ 12 operations
  - 100 numbers: ~700 operations average
  - 500 numbers: ~5500 operations average

## [1.0.0] - 2025-02-28

### Added
- Initial implementation of push_swap
- Chunk-based sorting algorithm
- Index-based element comparison
- Dynamic chunk size calculation
- Basic Makefile
- All required operations (push, swap, rotate, reverse rotate)
- Error handling for invalid input
- Support for negative numbers and edge cases

### Algorithm Features
- Optimized sorting for 2-3 elements
- Chunk division for larger sets
- Insertion sort from stack B
- Rotation direction optimization

---

## Future Improvements

### Planned for [2.1.0]
- [ ] Implement Turk algorithm for better performance
- [ ] Add bonus checker program
- [ ] Visualizer for sorting operations
- [ ] More comprehensive test suite
- [ ] CI/CD integration

### Potential Optimizations
- [ ] Adaptive chunk size calculation
- [ ] Look-ahead for combined operations
- [ ] Better use of double operations (rr, rrr, ss)
- [ ] Target: < 550 moves for 100 numbers
- [ ] Target: < 4000 moves for 500 numbers

---

**Maintained by**: Giovanni Nicolo (gnicolo@student.42firenze.it)
