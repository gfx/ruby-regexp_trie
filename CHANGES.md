Revision history of the RegexpTrie gem

## v1.0.2 - 2018/10/09

* Tested on Ruby v2.5
* Add `# frozen_string_literal: true` to source files

## v1.0.1 - 2018/10/09

* <del>Add `# frozen_string_literal: true` to source files</del> (<ins>it was not enabled; fixed in v1.0.2</ins>)

## v1.0.0 - 2016/11/14

- Add a method to get the union pattern as `String`, not as `Regexp`
    - `RegexpTrie.new(*patterns).to_source`

## v0.3.0 - 2016/04/20

- Fixed #1

## v0.2.0 - 2016/01/22

- Tweaks for documentation

## v0.1.0 - 2016/01/22

- Initial release
