# json-bigint

## Intro

JSON.parse/stringify with bigints support for HarmonyOS Next.

## Setup

```shell
ohpm install @ohmos/json-bigint
```

## Usage

- Example:

```arkts
import JSONbig from '@ohmos/json-bigint'

var json = '{ "value" : 9223372036854775807, "v2": 123 }';
console.log('Input:', json);
console.log('');

console.log('node.js built-in JSON:');
var r = JSON.parse(json);
console.log('JSON.parse(input).value : ', r.value.toString());
console.log('JSON.stringify(JSON.parse(input)):', JSON.stringify(r));

console.log('\n\nbig number JSON:');
var r1 = JSONbig.parse(json);
console.log('JSONbig.parse(input).value : ', r1.value.toString());
console.log('JSONbig.stringify(JSONbig.parse(input)):', JSONbig.stringify(r1));
```

- Output:

```text
Input: { "value" : 9223372036854775807, "v2": 123 }

node.js built-in JSON:
JSON.parse(input).value :  9223372036854776000
JSON.stringify(JSON.parse(input)): {"value":9223372036854776000,"v2":123}


big number JSON:
JSONbig.parse(input).value :  9223372036854775807
JSONbig.stringify(JSONbig.parse(input)): {"value":9223372036854775807,"v2":123}
```

## Other

You can see https://github.com/sidorares/json-bigint

## Connect

- 仓库：https://github.com/HarmonyOS-Next/mini-calendar
- 作者：zhousg1007@qq.com

