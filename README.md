# Rift

[![Build Status](https://travis-ci.org/nick-jones/rift.svg?branch=master)](https://travis-ci.org/nick-jones/rift)

This is a [Thrift IDL](http://thrift.apache.org/docs/idl) parser written in Ruby.

## About

Rift parses Thrift IDL into a simple abstract syntax tree. It uses [Rexical](https://github.com/tenderlove/rexical)
for lexing, and [Racc](https://github.com/tenderlove/racc) for parsing. The Thrift IDL grammar is largely supported;
constructs tagged as deprecated within the Thrift project are not permitted. Also, text from doc comments are not
currently represented in the tree.

## Why

Largely an excuse to play with Rexical and Racc, but you may find some practical uses for it.

## Running

An executable, `./bin/rift` is available, simply for testing purposes. It simply outputs a YAML representation of
the syntax tree. For example, the following IDL:

```
struct Location {
  1: required double latitude;
  2: required double longitude;
}
```

Will result in a syntax tree similar to the following:

```yaml
---
- !ruby/object:Rift::Nodes::Struct
  name: Location
  type: struct
  annotations:
  members:
  - !ruby/object:Rift::Nodes::Field
    identifier: !ruby/object:Rift::Nodes::FieldIdentifier
      auto_assigned: false
      value: 1
    name: latitude
    requiredness: required
    type: !ruby/object:Rift::Nodes::FieldType
      type: primitive
      value: !ruby/object:Rift::Nodes::BaseType
        annotations:
        type: double
    value:
    xsd_attributes:
    xsd_nillable: false
    xsd_optional: false
  - !ruby/object:Rift::Nodes::Field
    identifier: !ruby/object:Rift::Nodes::FieldIdentifier
      auto_assigned: false
      value: 2
    name: longitude
    requiredness: required
    type: !ruby/object:Rift::Nodes::FieldType
      type: primitive
      value: !ruby/object:Rift::Nodes::BaseType
        annotations:
        type: double
    value:
    xsd_attributes:
    xsd_nillable: false
    xsd_optional: false
```
