# This has largely been adapted from:
# https://git-wip-us.apache.org/repos/asf?p=thrift.git;a=blob;f=compiler/cpp/src/thriftl.ll;hb=HEAD

module Rift
module Generated
class Tokenizer

inner
  def reserved_keyword(keyword)
    raise "Keyword #{keyword} is reserved"
  end

  def deprecated_construct(construct)
    raise "'#{construct}' has been deprecated"
  end

  def unexpected_token(value)
    raise Rift::ParseError, "Unexpected token in input: '#{value}'"
  end

  def interpret_string_literal(value)
    mark = value[0]
    value[1..-2].gsub(/\\[rnt\\]/, {
      '\r' => "\r", '\n' => "\n",
      '\t' => "\t", '\\\\' => '\\'
    }).gsub("\\#{mark}", mark)
  end

  def register_doc_text_candidate(text)
    @doc_text = text
  end

macro
  CONSTANT_INT              [+-]?[0-9]+
  CONSTANT_HEX              [+-]?0x[0-9A-Fa-f]+
  CONSTANT_DOUBLE           [+-]?([0-9]+\.([0-9]+)?|(\.[0-9]+))([eE][+-]?[0-9]+)?
  IDENTIFIER                [a-zA-Z_](\.[a-zA-Z_0-9]|[a-zA-Z_0-9])*
  WHITESPACE                [\s]+
  B                         \b
  COMMENT_RULE              \/\*\**\*\/
  COMMENT_MULTI             \/\*[^*]\/*([^*\/]|[^*]\/|\*[^\/])*\**\*\/
  COMMENT_DOC               \/\*\*([^*\/]|[^*]\/|\*[^\/])*\**\*\/
  COMMENT_SINGLE            \/\/[^\n]*
  COMMENT_UNIX              \#[^\n]*
  SYMBOL                    [:;\,\{\}\(\)\=<>\[\]]
  ST_IDENTIFIER             [a-zA-Z-](\.[a-zA-Z_0-9-]|[a-zA-Z_0-9-])*
  LITERAL_DOUBLE            "[^"\\]*(?:\\.[^"\\]*)*"
  LITERAL_SINGLE            '[^'\\]*(?:\\.[^'\\]*)*'
  LITERAL                   ({LITERAL_DOUBLE}|{LITERAL_SINGLE})
  BOOL                      true|false

rule
  {WHITESPACE}              { next_token }

  {COMMENT_RULE}            { next_token }
  {COMMENT_MULTI}           { next_token }
  {COMMENT_DOC}             { register_doc_text_candidate(text) ; next_token }
  {COMMENT_SINGLE}          { next_token }
  {COMMENT_UNIX}            { next_token }

  {SYMBOL}                  { [text, text] }
  \*                        { [text, text] }
  &                         { [:REFERENCE, text] }
  {BOOL}                    { [:CONSTANT_INT, text == "true" ? 1 : 0] }

  {B}namespace{B}           { [:NAMESPACE, text] }
  {B}cpp_include{B}         { [:CPP_INCLUDE, text] }
  {B}cpp_type{B}            { [:CPP_TYPE, text] }
  {B}java_package{B}        { [:JAVA_PACKAGE, text] }
  {B}cocoa_prefix{B}        { [:COCOA_PREFIX, text] }
  {B}py_module{B}           { [:PY_MODULE, text] }
  {B}perl_package{B}        { [:PERL_PACKAGE, text] }
  {B}smalltalk_category{B}  { [:SMALLTALK_CATEGORY, text] }
  {B}smalltalk_prefix{B}    { [:SMALLTALK_PREFIX, text] }
  {B}xsd_all{B}             { [:XSD_ALL, text] }
  {B}xsd_optional{B}        { [:XSD_OPTIONAL, text] }
  {B}xsd_nillable{B}        { [:XSD_NILLABLE, text] }
  {B}xsd_attrs{B}           { [:XSD_ATTRS, text] }
  {B}include{B}             { [:INCLUDE, text] }
  {B}void{B}                { [:VOID, text] }
  {B}bool{B}                { [:BOOL, text] }
  {B}byte{B}                { [:I8, text] }
  {B}i8{B}                  { [:I8, text] }
  {B}i16{B}                 { [:I16, text] }
  {B}i32{B}                 { [:I32, text] }
  {B}i64{B}                 { [:I64, text] }
  {B}double{B}              { [:DOUBLE, text] }
  {B}string{B}              { [:STRING, text] }
  {B}binary{B}              { [:BINARY, text] }
  {B}map{B}                 { [:MAP, text] }
  {B}list{B}                { [:LIST, text] }
  {B}set{B}                 { [:SET, text] }
  {B}oneway{B}              { [:ONEWAY, text] }
  {B}typedef{B}             { [:TYPEDEF, text] }
  {B}struct{B}              { [:STRUCT, text] }
  {B}union{B}               { [:UNION, text] }
  {B}exception{B}           { [:EXCEPTION, text] }
  {B}extends{B}             { [:EXTENDS, text] }
  {B}throws{B}              { [:THROWS, text] }
  {B}service{B}             { [:SERVICE, text] }
  {B}enum{B}                { [:ENUM, text] }
  {B}const{B}               { [:CONST, text] }
  {B}required{B}            { [:REQUIRED, text] }
  {B}optional{B}            { [:OPTIONAL, text] }

  {B}slist{B}               { deprecated_construct(text) }
  {B}senum{B}               { deprecated_construct(text) }
  {B}async{B}               { deprecated_construct(text) }
  {B}cpp_namespace{B}       { deprecated_construct(text) }
  {B}php_namespace{B}       { deprecated_construct(text) }
  {B}py_module{B}           { deprecated_construct(text) }
  {B}perl_package{B}        { deprecated_construct(text) }
  {B}ruby_namespace{B}      { deprecated_construct(text) }
  {B}smalltalk_category{B}  { deprecated_construct(text) }
  {B}smalltalk_prefix{B}    { deprecated_construct(text) }
  {B}java_package{B}        { deprecated_construct(text) }
  {B}cocoa_prefix{B}        { deprecated_construct(text) }
  {B}xsd_namespace{B}       { deprecated_construct(text) }
  {B}csharp_namespace{B}    { deprecated_construct(text) }
  {B}delphi_namespace{B}    { deprecated_construct(text) }

  {B}BEGIN{B}               { reserved_keyword(text) }
  {B}END{B}                 { reserved_keyword(text) }
  {B}__CLASS__{B}           { reserved_keyword(text) }
  {B}__DIR__{B}             { reserved_keyword(text) }
  {B}__FILE__{B}            { reserved_keyword(text) }
  {B}__FUNCTION__{B}        { reserved_keyword(text) }
  {B}__LINE__{B}            { reserved_keyword(text) }
  {B}__METHOD__{B}          { reserved_keyword(text) }
  {B}__NAMESPACE__{B}       { reserved_keyword(text) }
  {B}abstract{B}            { reserved_keyword(text) }
  {B}alias{B}               { reserved_keyword(text) }
  {B}and{B}                 { reserved_keyword(text) }
  {B}args{B}                { reserved_keyword(text) }
  {B}as{B}                  { reserved_keyword(text) }
  {B}assert{B}              { reserved_keyword(text) }
  {B}begin{B}               { reserved_keyword(text) }
  {B}break{B}               { reserved_keyword(text) }
  {B}case{B}                { reserved_keyword(text) }
  {B}catch{B}               { reserved_keyword(text) }
  {B}class{B}               { reserved_keyword(text) }
  {B}clone{B}               { reserved_keyword(text) }
  {B}continue{B}            { reserved_keyword(text) }
  {B}declare{B}             { reserved_keyword(text) }
  {B}def{B}                 { reserved_keyword(text) }
  {B}default{B}             { reserved_keyword(text) }
  {B}del{B}                 { reserved_keyword(text) }
  {B}delete{B}              { reserved_keyword(text) }
  {B}do{B}                  { reserved_keyword(text) }
  {B}dynamic{B}             { reserved_keyword(text) }
  {B}elif{B}                { reserved_keyword(text) }
  {B}else{B}                { reserved_keyword(text) }
  {B}elseif{B}              { reserved_keyword(text) }
  {B}elsif{B}               { reserved_keyword(text) }
  {B}end{B}                 { reserved_keyword(text) }
  {B}enddeclare{B}          { reserved_keyword(text) }
  {B}endfor{B}              { reserved_keyword(text) }
  {B}endforeach{B}          { reserved_keyword(text) }
  {B}endif{B}               { reserved_keyword(text) }
  {B}endswitch{B}           { reserved_keyword(text) }
  {B}endwhile{B}            { reserved_keyword(text) }
  {B}ensure{B}              { reserved_keyword(text) }
  {B}except{B}              { reserved_keyword(text) }
  {B}exec{B}                { reserved_keyword(text) }
  {B}finally{B}             { reserved_keyword(text) }
  {B}float{B}               { reserved_keyword(text) }
  {B}for{B}                 { reserved_keyword(text) }
  {B}foreach{B}             { reserved_keyword(text) }
  {B}from{B}                { reserved_keyword(text) }
  {B}function{B}            { reserved_keyword(text) }
  {B}global{B}              { reserved_keyword(text) }
  {B}goto{B}                { reserved_keyword(text) }
  {B}if{B}                  { reserved_keyword(text) }
  {B}implements{B}          { reserved_keyword(text) }
  {B}import{B}              { reserved_keyword(text) }
  {B}in{B}                  { reserved_keyword(text) }
  {B}inline{B}              { reserved_keyword(text) }
  {B}instanceof{B}          { reserved_keyword(text) }
  {B}interface{B}           { reserved_keyword(text) }
  {B}is{B}                  { reserved_keyword(text) }
  {B}lambda{B}              { reserved_keyword(text) }
  {B}module{B}              { reserved_keyword(text) }
  {B}native{B}              { reserved_keyword(text) }
  {B}new{B}                 { reserved_keyword(text) }
  {B}next{B}                { reserved_keyword(text) }
  {B}nil{B}                 { reserved_keyword(text) }
  {B}not{B}                 { reserved_keyword(text) }
  {B}or{B}                  { reserved_keyword(text) }
  {B}package{B}             { reserved_keyword(text) }
  {B}pass{B}                { reserved_keyword(text) }
  {B}public{B}              { reserved_keyword(text) }
  {B}print{B}               { reserved_keyword(text) }
  {B}private{B}             { reserved_keyword(text) }
  {B}protected{B}           { reserved_keyword(text) }
  {B}public{B}              { reserved_keyword(text) }
  {B}raise{B}               { reserved_keyword(text) }
  {B}redo{B}                { reserved_keyword(text) }
  {B}rescue{B}              { reserved_keyword(text) }
  {B}retry{B}               { reserved_keyword(text) }
  {B}register{B}            { reserved_keyword(text) }
  {B}return{B}              { reserved_keyword(text) }
  {B}self{B}                { reserved_keyword(text) }
  {B}sizeof{B}              { reserved_keyword(text) }
  {B}static{B}              { reserved_keyword(text) }
  {B}super{B}               { reserved_keyword(text) }
  {B}switch{B}              { reserved_keyword(text) }
  {B}synchronized{B}        { reserved_keyword(text) }
  {B}then{B}                { reserved_keyword(text) }
  {B}this{B}                { reserved_keyword(text) }
  {B}throw{B}               { reserved_keyword(text) }
  {B}transient{B}           { reserved_keyword(text) }
  {B}try{B}                 { reserved_keyword(text) }
  {B}undef{B}               { reserved_keyword(text) }
  {B}union{B}               { reserved_keyword(text) }
  {B}unless{B}              { reserved_keyword(text) }
  {B}unsigned{B}            { reserved_keyword(text) }
  {B}until{B}               { reserved_keyword(text) }
  {B}use{B}                 { reserved_keyword(text) }
  {B}var{B}                 { reserved_keyword(text) }
  {B}virtual{B}             { reserved_keyword(text) }
  {B}volatile{B}            { reserved_keyword(text) }
  {B}when{B}                { reserved_keyword(text) }
  {B}while{B}               { reserved_keyword(text) }
  {B}with{B}                { reserved_keyword(text) }
  {B}xor{B}                 { reserved_keyword(text) }
  {B}yield{B}               { reserved_keyword(text) }

  {CONSTANT_DOUBLE}         { [:CONSTANT_DOUBLE, text.to_f] }
  {CONSTANT_HEX}            { [:CONSTANT_INT, text.to_i(16)] }
  {CONSTANT_INT}            { [:CONSTANT_INT, text.to_i] }
  {IDENTIFIER}              { [:IDENTIFIER, text] }
  {LITERAL}                 { [:LITERAL, interpret_string_literal(text)] }
  {ST_IDENTIFIER}           { [:ST_IDENTIFIER, text] }

  .                         { unexpected_token(text) }

end
  end
  end
  end