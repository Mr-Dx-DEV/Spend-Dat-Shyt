'use strict';
var __create = Object.create;
var __defProp = Object.defineProperty;
var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __getProtoOf = Object.getPrototypeOf,
  __hasOwnProp = Object.prototype.hasOwnProperty;
var __commonJS = (cb, mod) =>
  function () {
    return (mod || (0, cb[__getOwnPropNames(cb)[0]])((mod = { exports: {} }).exports, mod), mod.exports);
  };
var __export = (target, all) => {
    for (var name in all) __defProp(target, name, { get: all[name], enumerable: !0 });
  },
  __copyProps = (to, from, except, desc) => {
    if ((from && typeof from == 'object') || typeof from == 'function')
      for (let key of __getOwnPropNames(from))
        !__hasOwnProp.call(to, key) &&
          key !== except &&
          __defProp(to, key, {
            get: () => from[key],
            enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable,
          });
    return to;
  };
var __toESM = (mod, isNodeMode, target) => (
    (target = mod != null ? __create(__getProtoOf(mod)) : {}),
    __copyProps(
      isNodeMode || !mod || !mod.__esModule ? __defProp(target, 'default', { value: mod, enumerable: !0 }) : target,
      mod
    )
  ),
  __toCommonJS = (mod) => __copyProps(__defProp({}, '__esModule', { value: !0 }), mod);
var require_long = __commonJS({
  'node_modules/long/dist/long.js'(exports2, module2) {
    'use strict';
    (function (global2, factory) {
      typeof define == 'function' && define.amd
        ? define([], factory)
        : typeof require == 'function' && typeof module2 == 'object' && module2 && module2.exports
          ? (module2.exports = factory())
          : ((global2.dcodeIO = global2.dcodeIO || {}).Long = factory());
    })(exports2, function () {
      'use strict';
      function Long(low, high, unsigned) {
        ((this.low = low | 0), (this.high = high | 0), (this.unsigned = !!unsigned));
      }
      (Long.prototype.__isLong__,
        Object.defineProperty(Long.prototype, '__isLong__', { value: !0, enumerable: !1, configurable: !1 }));
      function isLong(obj) {
        return (obj && obj.__isLong__) === !0;
      }
      Long.isLong = isLong;
      var INT_CACHE = {},
        UINT_CACHE = {};
      function fromInt(value, unsigned) {
        var obj, cachedObj, cache;
        return unsigned
          ? ((value >>>= 0),
            (cache = 0 <= value && value < 256) && ((cachedObj = UINT_CACHE[value]), cachedObj)
              ? cachedObj
              : ((obj = fromBits(value, (value | 0) < 0 ? -1 : 0, !0)), cache && (UINT_CACHE[value] = obj), obj))
          : ((value |= 0),
            (cache = -128 <= value && value < 128) && ((cachedObj = INT_CACHE[value]), cachedObj)
              ? cachedObj
              : ((obj = fromBits(value, value < 0 ? -1 : 0, !1)), cache && (INT_CACHE[value] = obj), obj));
      }
      Long.fromInt = fromInt;
      function fromNumber(value, unsigned) {
        if (isNaN(value) || !isFinite(value)) return unsigned ? UZERO : ZERO;
        if (unsigned) {
          if (value < 0) return UZERO;
          if (value >= TWO_PWR_64_DBL) return MAX_UNSIGNED_VALUE;
        } else {
          if (value <= -TWO_PWR_63_DBL) return MIN_VALUE;
          if (value + 1 >= TWO_PWR_63_DBL) return MAX_VALUE;
        }
        return value < 0
          ? fromNumber(-value, unsigned).neg()
          : fromBits((value % TWO_PWR_32_DBL) | 0, (value / TWO_PWR_32_DBL) | 0, unsigned);
      }
      Long.fromNumber = fromNumber;
      function fromBits(lowBits, highBits, unsigned) {
        return new Long(lowBits, highBits, unsigned);
      }
      Long.fromBits = fromBits;
      var pow_dbl = Math.pow;
      function fromString(str, unsigned, radix) {
        if (str.length === 0) throw Error('empty string');
        if (str === 'NaN' || str === 'Infinity' || str === '+Infinity' || str === '-Infinity') return ZERO;
        if (
          (typeof unsigned == 'number' ? ((radix = unsigned), (unsigned = !1)) : (unsigned = !!unsigned),
          (radix = radix || 10),
          radix < 2 || 36 < radix)
        )
          throw RangeError('radix');
        var p;
        if ((p = str.indexOf('-')) > 0) throw Error('interior hyphen');
        if (p === 0) return fromString(str.substring(1), unsigned, radix).neg();
        for (var radixToPower = fromNumber(pow_dbl(radix, 8)), result = ZERO, i = 0; i < str.length; i += 8) {
          var size = Math.min(8, str.length - i),
            value = parseInt(str.substring(i, i + size), radix);
          if (size < 8) {
            var power = fromNumber(pow_dbl(radix, size));
            result = result.mul(power).add(fromNumber(value));
          } else ((result = result.mul(radixToPower)), (result = result.add(fromNumber(value))));
        }
        return ((result.unsigned = unsigned), result);
      }
      Long.fromString = fromString;
      function fromValue(val) {
        return val instanceof Long
          ? val
          : typeof val == 'number'
            ? fromNumber(val)
            : typeof val == 'string'
              ? fromString(val)
              : fromBits(val.low, val.high, val.unsigned);
      }
      Long.fromValue = fromValue;
      var TWO_PWR_16_DBL = 65536,
        TWO_PWR_24_DBL = 1 << 24,
        TWO_PWR_32_DBL = TWO_PWR_16_DBL * TWO_PWR_16_DBL,
        TWO_PWR_64_DBL = TWO_PWR_32_DBL * TWO_PWR_32_DBL,
        TWO_PWR_63_DBL = TWO_PWR_64_DBL / 2,
        TWO_PWR_24 = fromInt(TWO_PWR_24_DBL),
        ZERO = fromInt(0);
      Long.ZERO = ZERO;
      var UZERO = fromInt(0, !0);
      Long.UZERO = UZERO;
      var ONE = fromInt(1);
      Long.ONE = ONE;
      var UONE = fromInt(1, !0);
      Long.UONE = UONE;
      var NEG_ONE = fromInt(-1);
      Long.NEG_ONE = NEG_ONE;
      var MAX_VALUE = fromBits(-1, 2147483647, !1);
      Long.MAX_VALUE = MAX_VALUE;
      var MAX_UNSIGNED_VALUE = fromBits(-1, -1, !0);
      Long.MAX_UNSIGNED_VALUE = MAX_UNSIGNED_VALUE;
      var MIN_VALUE = fromBits(0, -2147483648, !1);
      Long.MIN_VALUE = MIN_VALUE;
      var LongPrototype = Long.prototype;
      return (
        (LongPrototype.toInt = function () {
          return this.unsigned ? this.low >>> 0 : this.low;
        }),
        (LongPrototype.toNumber = function () {
          return this.unsigned
            ? (this.high >>> 0) * TWO_PWR_32_DBL + (this.low >>> 0)
            : this.high * TWO_PWR_32_DBL + (this.low >>> 0);
        }),
        (LongPrototype.toString = function (radix) {
          if (((radix = radix || 10), radix < 2 || 36 < radix)) throw RangeError('radix');
          if (this.isZero()) return '0';
          if (this.isNegative())
            if (this.eq(MIN_VALUE)) {
              var radixLong = fromNumber(radix),
                div = this.div(radixLong),
                rem1 = div.mul(radixLong).sub(this);
              return div.toString(radix) + rem1.toInt().toString(radix);
            } else return '-' + this.neg().toString(radix);
          for (var radixToPower = fromNumber(pow_dbl(radix, 6), this.unsigned), rem = this, result = ''; ; ) {
            var remDiv = rem.div(radixToPower),
              intval = rem.sub(remDiv.mul(radixToPower)).toInt() >>> 0,
              digits = intval.toString(radix);
            if (((rem = remDiv), rem.isZero())) return digits + result;
            for (; digits.length < 6; ) digits = '0' + digits;
            result = '' + digits + result;
          }
        }),
        (LongPrototype.getHighBits = function () {
          return this.high;
        }),
        (LongPrototype.getHighBitsUnsigned = function () {
          return this.high >>> 0;
        }),
        (LongPrototype.getLowBits = function () {
          return this.low;
        }),
        (LongPrototype.getLowBitsUnsigned = function () {
          return this.low >>> 0;
        }),
        (LongPrototype.getNumBitsAbs = function () {
          if (this.isNegative()) return this.eq(MIN_VALUE) ? 64 : this.neg().getNumBitsAbs();
          for (var val = this.high != 0 ? this.high : this.low, bit = 31; bit > 0 && (val & (1 << bit)) == 0; bit--);
          return this.high != 0 ? bit + 33 : bit + 1;
        }),
        (LongPrototype.isZero = function () {
          return this.high === 0 && this.low === 0;
        }),
        (LongPrototype.isNegative = function () {
          return !this.unsigned && this.high < 0;
        }),
        (LongPrototype.isPositive = function () {
          return this.unsigned || this.high >= 0;
        }),
        (LongPrototype.isOdd = function () {
          return (this.low & 1) === 1;
        }),
        (LongPrototype.isEven = function () {
          return (this.low & 1) === 0;
        }),
        (LongPrototype.equals = function (other) {
          return (
            isLong(other) || (other = fromValue(other)),
            this.unsigned !== other.unsigned && this.high >>> 31 === 1 && other.high >>> 31 === 1
              ? !1
              : this.high === other.high && this.low === other.low
          );
        }),
        (LongPrototype.eq = LongPrototype.equals),
        (LongPrototype.notEquals = function (other) {
          return !this.eq(other);
        }),
        (LongPrototype.neq = LongPrototype.notEquals),
        (LongPrototype.lessThan = function (other) {
          return this.comp(other) < 0;
        }),
        (LongPrototype.lt = LongPrototype.lessThan),
        (LongPrototype.lessThanOrEqual = function (other) {
          return this.comp(other) <= 0;
        }),
        (LongPrototype.lte = LongPrototype.lessThanOrEqual),
        (LongPrototype.greaterThan = function (other) {
          return this.comp(other) > 0;
        }),
        (LongPrototype.gt = LongPrototype.greaterThan),
        (LongPrototype.greaterThanOrEqual = function (other) {
          return this.comp(other) >= 0;
        }),
        (LongPrototype.gte = LongPrototype.greaterThanOrEqual),
        (LongPrototype.compare = function (other) {
          if ((isLong(other) || (other = fromValue(other)), this.eq(other))) return 0;
          var thisNeg = this.isNegative(),
            otherNeg = other.isNegative();
          return thisNeg && !otherNeg
            ? -1
            : !thisNeg && otherNeg
              ? 1
              : this.unsigned
                ? other.high >>> 0 > this.high >>> 0 || (other.high === this.high && other.low >>> 0 > this.low >>> 0)
                  ? -1
                  : 1
                : this.sub(other).isNegative()
                  ? -1
                  : 1;
        }),
        (LongPrototype.comp = LongPrototype.compare),
        (LongPrototype.negate = function () {
          return !this.unsigned && this.eq(MIN_VALUE) ? MIN_VALUE : this.not().add(ONE);
        }),
        (LongPrototype.neg = LongPrototype.negate),
        (LongPrototype.add = function (addend) {
          isLong(addend) || (addend = fromValue(addend));
          var a48 = this.high >>> 16,
            a32 = this.high & 65535,
            a16 = this.low >>> 16,
            a00 = this.low & 65535,
            b48 = addend.high >>> 16,
            b32 = addend.high & 65535,
            b16 = addend.low >>> 16,
            b00 = addend.low & 65535,
            c48 = 0,
            c32 = 0,
            c16 = 0,
            c00 = 0;
          return (
            (c00 += a00 + b00),
            (c16 += c00 >>> 16),
            (c00 &= 65535),
            (c16 += a16 + b16),
            (c32 += c16 >>> 16),
            (c16 &= 65535),
            (c32 += a32 + b32),
            (c48 += c32 >>> 16),
            (c32 &= 65535),
            (c48 += a48 + b48),
            (c48 &= 65535),
            fromBits((c16 << 16) | c00, (c48 << 16) | c32, this.unsigned)
          );
        }),
        (LongPrototype.subtract = function (subtrahend) {
          return (isLong(subtrahend) || (subtrahend = fromValue(subtrahend)), this.add(subtrahend.neg()));
        }),
        (LongPrototype.sub = LongPrototype.subtract),
        (LongPrototype.multiply = function (multiplier) {
          if (this.isZero() || (isLong(multiplier) || (multiplier = fromValue(multiplier)), multiplier.isZero()))
            return ZERO;
          if (this.eq(MIN_VALUE)) return multiplier.isOdd() ? MIN_VALUE : ZERO;
          if (multiplier.eq(MIN_VALUE)) return this.isOdd() ? MIN_VALUE : ZERO;
          if (this.isNegative())
            return multiplier.isNegative() ? this.neg().mul(multiplier.neg()) : this.neg().mul(multiplier).neg();
          if (multiplier.isNegative()) return this.mul(multiplier.neg()).neg();
          if (this.lt(TWO_PWR_24) && multiplier.lt(TWO_PWR_24))
            return fromNumber(this.toNumber() * multiplier.toNumber(), this.unsigned);
          var a48 = this.high >>> 16,
            a32 = this.high & 65535,
            a16 = this.low >>> 16,
            a00 = this.low & 65535,
            b48 = multiplier.high >>> 16,
            b32 = multiplier.high & 65535,
            b16 = multiplier.low >>> 16,
            b00 = multiplier.low & 65535,
            c48 = 0,
            c32 = 0,
            c16 = 0,
            c00 = 0;
          return (
            (c00 += a00 * b00),
            (c16 += c00 >>> 16),
            (c00 &= 65535),
            (c16 += a16 * b00),
            (c32 += c16 >>> 16),
            (c16 &= 65535),
            (c16 += a00 * b16),
            (c32 += c16 >>> 16),
            (c16 &= 65535),
            (c32 += a32 * b00),
            (c48 += c32 >>> 16),
            (c32 &= 65535),
            (c32 += a16 * b16),
            (c48 += c32 >>> 16),
            (c32 &= 65535),
            (c32 += a00 * b32),
            (c48 += c32 >>> 16),
            (c32 &= 65535),
            (c48 += a48 * b00 + a32 * b16 + a16 * b32 + a00 * b48),
            (c48 &= 65535),
            fromBits((c16 << 16) | c00, (c48 << 16) | c32, this.unsigned)
          );
        }),
        (LongPrototype.mul = LongPrototype.multiply),
        (LongPrototype.divide = function (divisor) {
          if ((isLong(divisor) || (divisor = fromValue(divisor)), divisor.isZero())) throw Error('division by zero');
          if (this.isZero()) return this.unsigned ? UZERO : ZERO;
          var approx, rem, res;
          if (this.unsigned) {
            if ((divisor.unsigned || (divisor = divisor.toUnsigned()), divisor.gt(this))) return UZERO;
            if (divisor.gt(this.shru(1))) return UONE;
            res = UZERO;
          } else {
            if (this.eq(MIN_VALUE)) {
              if (divisor.eq(ONE) || divisor.eq(NEG_ONE)) return MIN_VALUE;
              if (divisor.eq(MIN_VALUE)) return ONE;
              var halfThis = this.shr(1);
              return (
                (approx = halfThis.div(divisor).shl(1)),
                approx.eq(ZERO)
                  ? divisor.isNegative()
                    ? ONE
                    : NEG_ONE
                  : ((rem = this.sub(divisor.mul(approx))), (res = approx.add(rem.div(divisor))), res)
              );
            } else if (divisor.eq(MIN_VALUE)) return this.unsigned ? UZERO : ZERO;
            if (this.isNegative())
              return divisor.isNegative() ? this.neg().div(divisor.neg()) : this.neg().div(divisor).neg();
            if (divisor.isNegative()) return this.div(divisor.neg()).neg();
            res = ZERO;
          }
          for (rem = this; rem.gte(divisor); ) {
            approx = Math.max(1, Math.floor(rem.toNumber() / divisor.toNumber()));
            for (
              var log2 = Math.ceil(Math.log(approx) / Math.LN2),
                delta = log2 <= 48 ? 1 : pow_dbl(2, log2 - 48),
                approxRes = fromNumber(approx),
                approxRem = approxRes.mul(divisor);
              approxRem.isNegative() || approxRem.gt(rem);
            )
              ((approx -= delta),
                (approxRes = fromNumber(approx, this.unsigned)),
                (approxRem = approxRes.mul(divisor)));
            (approxRes.isZero() && (approxRes = ONE), (res = res.add(approxRes)), (rem = rem.sub(approxRem)));
          }
          return res;
        }),
        (LongPrototype.div = LongPrototype.divide),
        (LongPrototype.modulo = function (divisor) {
          return (isLong(divisor) || (divisor = fromValue(divisor)), this.sub(this.div(divisor).mul(divisor)));
        }),
        (LongPrototype.mod = LongPrototype.modulo),
        (LongPrototype.not = function () {
          return fromBits(~this.low, ~this.high, this.unsigned);
        }),
        (LongPrototype.and = function (other) {
          return (
            isLong(other) || (other = fromValue(other)),
            fromBits(this.low & other.low, this.high & other.high, this.unsigned)
          );
        }),
        (LongPrototype.or = function (other) {
          return (
            isLong(other) || (other = fromValue(other)),
            fromBits(this.low | other.low, this.high | other.high, this.unsigned)
          );
        }),
        (LongPrototype.xor = function (other) {
          return (
            isLong(other) || (other = fromValue(other)),
            fromBits(this.low ^ other.low, this.high ^ other.high, this.unsigned)
          );
        }),
        (LongPrototype.shiftLeft = function (numBits) {
          return (
            isLong(numBits) && (numBits = numBits.toInt()),
            (numBits &= 63) === 0
              ? this
              : numBits < 32
                ? fromBits(this.low << numBits, (this.high << numBits) | (this.low >>> (32 - numBits)), this.unsigned)
                : fromBits(0, this.low << (numBits - 32), this.unsigned)
          );
        }),
        (LongPrototype.shl = LongPrototype.shiftLeft),
        (LongPrototype.shiftRight = function (numBits) {
          return (
            isLong(numBits) && (numBits = numBits.toInt()),
            (numBits &= 63) === 0
              ? this
              : numBits < 32
                ? fromBits((this.low >>> numBits) | (this.high << (32 - numBits)), this.high >> numBits, this.unsigned)
                : fromBits(this.high >> (numBits - 32), this.high >= 0 ? 0 : -1, this.unsigned)
          );
        }),
        (LongPrototype.shr = LongPrototype.shiftRight),
        (LongPrototype.shiftRightUnsigned = function (numBits) {
          if ((isLong(numBits) && (numBits = numBits.toInt()), (numBits &= 63), numBits === 0)) return this;
          var high = this.high;
          if (numBits < 32) {
            var low = this.low;
            return fromBits((low >>> numBits) | (high << (32 - numBits)), high >>> numBits, this.unsigned);
          } else
            return numBits === 32
              ? fromBits(high, 0, this.unsigned)
              : fromBits(high >>> (numBits - 32), 0, this.unsigned);
        }),
        (LongPrototype.shru = LongPrototype.shiftRightUnsigned),
        (LongPrototype.toSigned = function () {
          return this.unsigned ? fromBits(this.low, this.high, !1) : this;
        }),
        (LongPrototype.toUnsigned = function () {
          return this.unsigned ? this : fromBits(this.low, this.high, !0);
        }),
        (LongPrototype.toBytes = function (le) {
          return le ? this.toBytesLE() : this.toBytesBE();
        }),
        (LongPrototype.toBytesLE = function () {
          var hi = this.high,
            lo = this.low;
          return [
            lo & 255,
            (lo >>> 8) & 255,
            (lo >>> 16) & 255,
            (lo >>> 24) & 255,
            hi & 255,
            (hi >>> 8) & 255,
            (hi >>> 16) & 255,
            (hi >>> 24) & 255,
          ];
        }),
        (LongPrototype.toBytesBE = function () {
          var hi = this.high,
            lo = this.low;
          return [
            (hi >>> 24) & 255,
            (hi >>> 16) & 255,
            (hi >>> 8) & 255,
            hi & 255,
            (lo >>> 24) & 255,
            (lo >>> 16) & 255,
            (lo >>> 8) & 255,
            lo & 255,
          ];
        }),
        Long
      );
    });
  },
});
var require_bytebuffer_node = __commonJS({
  'node_modules/bytebuffer/dist/bytebuffer-node.js'(exports2, module2) {
    'use strict';
    module2.exports = (function () {
      'use strict';
      var buffer = require('buffer'),
        Buffer2 = buffer.Buffer,
        Long = require_long(),
        memcpy = null;
      try {
        memcpy = require('memcpy');
      } catch {}
      var ByteBuffer = function (capacity, littleEndian, noAssert) {
        if (
          (typeof capacity > 'u' && (capacity = ByteBuffer.DEFAULT_CAPACITY),
          typeof littleEndian > 'u' && (littleEndian = ByteBuffer.DEFAULT_ENDIAN),
          typeof noAssert > 'u' && (noAssert = ByteBuffer.DEFAULT_NOASSERT),
          !noAssert)
        ) {
          if (((capacity = capacity | 0), capacity < 0)) throw RangeError('Illegal capacity');
          ((littleEndian = !!littleEndian), (noAssert = !!noAssert));
        }
        ((this.buffer = capacity === 0 ? EMPTY_BUFFER : Buffer2.allocUnsafe(capacity)),
          (this.offset = 0),
          (this.markedOffset = -1),
          (this.limit = capacity),
          (this.littleEndian = littleEndian),
          (this.noAssert = noAssert));
      };
      ((ByteBuffer.VERSION = '5.0.1'),
        (ByteBuffer.LITTLE_ENDIAN = !0),
        (ByteBuffer.BIG_ENDIAN = !1),
        (ByteBuffer.DEFAULT_CAPACITY = 16),
        (ByteBuffer.DEFAULT_ENDIAN = ByteBuffer.BIG_ENDIAN),
        (ByteBuffer.DEFAULT_NOASSERT = !1),
        (ByteBuffer.Long = Long));
      var ByteBufferPrototype = ByteBuffer.prototype;
      (ByteBufferPrototype.__isByteBuffer__,
        Object.defineProperty(ByteBufferPrototype, '__isByteBuffer__', {
          value: !0,
          enumerable: !1,
          configurable: !1,
        }));
      var EMPTY_BUFFER = Buffer2.allocUnsafe(0),
        stringFromCharCode = String.fromCharCode;
      function stringSource(s) {
        var i = 0;
        return function () {
          return i < s.length ? s.charCodeAt(i++) : null;
        };
      }
      function stringDestination() {
        var cs = [],
          ps = [];
        return function () {
          if (arguments.length === 0) return ps.join('') + stringFromCharCode.apply(String, cs);
          (cs.length + arguments.length > 1024 && (ps.push(stringFromCharCode.apply(String, cs)), (cs.length = 0)),
            Array.prototype.push.apply(cs, arguments));
        };
      }
      ((ByteBuffer.accessor = function () {
        return Buffer2;
      }),
        (ByteBuffer.allocate = function (capacity, littleEndian, noAssert) {
          return new ByteBuffer(capacity, littleEndian, noAssert);
        }),
        (ByteBuffer.concat = function (buffers, encoding, littleEndian, noAssert) {
          (typeof encoding == 'boolean' || typeof encoding != 'string') &&
            ((noAssert = littleEndian), (littleEndian = encoding), (encoding = void 0));
          for (var capacity = 0, i = 0, k = buffers.length, length; i < k; ++i)
            (ByteBuffer.isByteBuffer(buffers[i]) || (buffers[i] = ByteBuffer.wrap(buffers[i], encoding)),
              (length = buffers[i].limit - buffers[i].offset),
              length > 0 && (capacity += length));
          if (capacity === 0) return new ByteBuffer(0, littleEndian, noAssert);
          var bb2 = new ByteBuffer(capacity, littleEndian, noAssert),
            bi;
          for (i = 0; i < k; )
            ((bi = buffers[i++]),
              (length = bi.limit - bi.offset),
              !(length <= 0) && (bi.buffer.copy(bb2.buffer, bb2.offset, bi.offset, bi.limit), (bb2.offset += length)));
          return ((bb2.limit = bb2.offset), (bb2.offset = 0), bb2);
        }),
        (ByteBuffer.isByteBuffer = function (bb2) {
          return (bb2 && bb2.__isByteBuffer__) === !0;
        }),
        (ByteBuffer.type = function () {
          return Buffer2;
        }),
        (ByteBuffer.wrap = function (buffer2, encoding, littleEndian, noAssert) {
          if (
            (typeof encoding != 'string' && ((noAssert = littleEndian), (littleEndian = encoding), (encoding = void 0)),
            typeof buffer2 == 'string')
          )
            switch ((typeof encoding > 'u' && (encoding = 'utf8'), encoding)) {
              case 'base64':
                return ByteBuffer.fromBase64(buffer2, littleEndian);
              case 'hex':
                return ByteBuffer.fromHex(buffer2, littleEndian);
              case 'binary':
                return ByteBuffer.fromBinary(buffer2, littleEndian);
              case 'utf8':
                return ByteBuffer.fromUTF8(buffer2, littleEndian);
              case 'debug':
                return ByteBuffer.fromDebug(buffer2, littleEndian);
              default:
                throw Error('Unsupported encoding: ' + encoding);
            }
          if (buffer2 === null || typeof buffer2 != 'object') throw TypeError('Illegal buffer');
          var bb2;
          if (ByteBuffer.isByteBuffer(buffer2))
            return ((bb2 = ByteBufferPrototype.clone.call(buffer2)), (bb2.markedOffset = -1), bb2);
          var i = 0,
            k = 0,
            b;
          if (buffer2 instanceof Uint8Array) {
            if (((b = Buffer2.allocUnsafe(buffer2.length)), memcpy))
              memcpy(b, 0, buffer2.buffer, buffer2.byteOffset, buffer2.byteOffset + buffer2.length);
            else for (i = 0, k = buffer2.length; i < k; ++i) b[i] = buffer2[i];
            buffer2 = b;
          } else if (buffer2 instanceof ArrayBuffer) {
            if (((b = Buffer2.allocUnsafe(buffer2.byteLength)), memcpy)) memcpy(b, 0, buffer2, 0, buffer2.byteLength);
            else for (buffer2 = new Uint8Array(buffer2), i = 0, k = buffer2.length; i < k; ++i) b[i] = buffer2[i];
            buffer2 = b;
          } else if (!(buffer2 instanceof Buffer2)) {
            if (Object.prototype.toString.call(buffer2) !== '[object Array]') throw TypeError('Illegal buffer');
            buffer2 = Buffer2.from(buffer2);
          }
          return (
            (bb2 = new ByteBuffer(0, littleEndian, noAssert)),
            buffer2.length > 0 && ((bb2.buffer = buffer2), (bb2.limit = buffer2.length)),
            bb2
          );
        }),
        (ByteBufferPrototype.writeBitSet = function (value, offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (!(value instanceof Array)) throw TypeError('Illegal BitSet: Not an array');
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
          }
          var start = offset,
            bits = value.length,
            bytes = bits >> 3,
            bit = 0,
            k;
          for (offset += this.writeVarint32(bits, offset); bytes--; )
            ((k =
              (!!value[bit++] & 1) |
              ((!!value[bit++] & 1) << 1) |
              ((!!value[bit++] & 1) << 2) |
              ((!!value[bit++] & 1) << 3) |
              ((!!value[bit++] & 1) << 4) |
              ((!!value[bit++] & 1) << 5) |
              ((!!value[bit++] & 1) << 6) |
              ((!!value[bit++] & 1) << 7)),
              this.writeByte(k, offset++));
          if (bit < bits) {
            var m = 0;
            for (k = 0; bit < bits; ) k = k | ((!!value[bit++] & 1) << m++);
            this.writeByte(k, offset++);
          }
          return relative ? ((this.offset = offset), this) : offset - start;
        }),
        (ByteBufferPrototype.readBitSet = function (offset) {
          var relative = typeof offset > 'u';
          relative && (offset = this.offset);
          var ret = this.readVarint32(offset),
            bits = ret.value,
            bytes = bits >> 3,
            bit = 0,
            value = [],
            k;
          for (offset += ret.length; bytes--; )
            ((k = this.readByte(offset++)),
              (value[bit++] = !!(k & 1)),
              (value[bit++] = !!(k & 2)),
              (value[bit++] = !!(k & 4)),
              (value[bit++] = !!(k & 8)),
              (value[bit++] = !!(k & 16)),
              (value[bit++] = !!(k & 32)),
              (value[bit++] = !!(k & 64)),
              (value[bit++] = !!(k & 128)));
          if (bit < bits) {
            var m = 0;
            for (k = this.readByte(offset++); bit < bits; ) value[bit++] = !!((k >> m++) & 1);
          }
          return (relative && (this.offset = offset), value);
        }),
        (ByteBufferPrototype.readBytes = function (length, offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + length > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+' + length + ') <= ' + this.buffer.length);
          }
          var slice = this.slice(offset, offset + length);
          return (relative && (this.offset += length), slice);
        }),
        (ByteBufferPrototype.writeBytes = ByteBufferPrototype.append),
        (ByteBufferPrototype.writeInt8 = function (value, offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof value != 'number' || value % 1 !== 0)
              throw TypeError('Illegal value: ' + value + ' (not an integer)');
            if (((value |= 0), typeof offset != 'number' || offset % 1 !== 0))
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
          }
          offset += 1;
          var capacity0 = this.buffer.length;
          return (
            offset > capacity0 && this.resize((capacity0 *= 2) > offset ? capacity0 : offset),
            (offset -= 1),
            (this.buffer[offset] = value),
            relative && (this.offset += 1),
            this
          );
        }),
        (ByteBufferPrototype.writeByte = ByteBufferPrototype.writeInt8),
        (ByteBufferPrototype.readInt8 = function (offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 1 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+1) <= ' + this.buffer.length);
          }
          var value = this.buffer[offset];
          return ((value & 128) === 128 && (value = -(255 - value + 1)), relative && (this.offset += 1), value);
        }),
        (ByteBufferPrototype.readByte = ByteBufferPrototype.readInt8),
        (ByteBufferPrototype.writeUint8 = function (value, offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof value != 'number' || value % 1 !== 0)
              throw TypeError('Illegal value: ' + value + ' (not an integer)');
            if (((value >>>= 0), typeof offset != 'number' || offset % 1 !== 0))
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
          }
          offset += 1;
          var capacity1 = this.buffer.length;
          return (
            offset > capacity1 && this.resize((capacity1 *= 2) > offset ? capacity1 : offset),
            (offset -= 1),
            (this.buffer[offset] = value),
            relative && (this.offset += 1),
            this
          );
        }),
        (ByteBufferPrototype.writeUInt8 = ByteBufferPrototype.writeUint8),
        (ByteBufferPrototype.readUint8 = function (offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 1 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+1) <= ' + this.buffer.length);
          }
          var value = this.buffer[offset];
          return (relative && (this.offset += 1), value);
        }),
        (ByteBufferPrototype.readUInt8 = ByteBufferPrototype.readUint8),
        (ByteBufferPrototype.writeInt16 = function (value, offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof value != 'number' || value % 1 !== 0)
              throw TypeError('Illegal value: ' + value + ' (not an integer)');
            if (((value |= 0), typeof offset != 'number' || offset % 1 !== 0))
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
          }
          offset += 2;
          var capacity2 = this.buffer.length;
          return (
            offset > capacity2 && this.resize((capacity2 *= 2) > offset ? capacity2 : offset),
            (offset -= 2),
            this.littleEndian
              ? ((this.buffer[offset + 1] = (value & 65280) >>> 8), (this.buffer[offset] = value & 255))
              : ((this.buffer[offset] = (value & 65280) >>> 8), (this.buffer[offset + 1] = value & 255)),
            relative && (this.offset += 2),
            this
          );
        }),
        (ByteBufferPrototype.writeShort = ByteBufferPrototype.writeInt16),
        (ByteBufferPrototype.readInt16 = function (offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 2 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+2) <= ' + this.buffer.length);
          }
          var value = 0;
          return (
            this.littleEndian
              ? ((value = this.buffer[offset]), (value |= this.buffer[offset + 1] << 8))
              : ((value = this.buffer[offset] << 8), (value |= this.buffer[offset + 1])),
            (value & 32768) === 32768 && (value = -(65535 - value + 1)),
            relative && (this.offset += 2),
            value
          );
        }),
        (ByteBufferPrototype.readShort = ByteBufferPrototype.readInt16),
        (ByteBufferPrototype.writeUint16 = function (value, offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof value != 'number' || value % 1 !== 0)
              throw TypeError('Illegal value: ' + value + ' (not an integer)');
            if (((value >>>= 0), typeof offset != 'number' || offset % 1 !== 0))
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
          }
          offset += 2;
          var capacity3 = this.buffer.length;
          return (
            offset > capacity3 && this.resize((capacity3 *= 2) > offset ? capacity3 : offset),
            (offset -= 2),
            this.littleEndian
              ? ((this.buffer[offset + 1] = (value & 65280) >>> 8), (this.buffer[offset] = value & 255))
              : ((this.buffer[offset] = (value & 65280) >>> 8), (this.buffer[offset + 1] = value & 255)),
            relative && (this.offset += 2),
            this
          );
        }),
        (ByteBufferPrototype.writeUInt16 = ByteBufferPrototype.writeUint16),
        (ByteBufferPrototype.readUint16 = function (offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 2 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+2) <= ' + this.buffer.length);
          }
          var value = 0;
          return (
            this.littleEndian
              ? ((value = this.buffer[offset]), (value |= this.buffer[offset + 1] << 8))
              : ((value = this.buffer[offset] << 8), (value |= this.buffer[offset + 1])),
            relative && (this.offset += 2),
            value
          );
        }),
        (ByteBufferPrototype.readUInt16 = ByteBufferPrototype.readUint16),
        (ByteBufferPrototype.writeInt32 = function (value, offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof value != 'number' || value % 1 !== 0)
              throw TypeError('Illegal value: ' + value + ' (not an integer)');
            if (((value |= 0), typeof offset != 'number' || offset % 1 !== 0))
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
          }
          offset += 4;
          var capacity4 = this.buffer.length;
          return (
            offset > capacity4 && this.resize((capacity4 *= 2) > offset ? capacity4 : offset),
            (offset -= 4),
            this.littleEndian
              ? ((this.buffer[offset + 3] = (value >>> 24) & 255),
                (this.buffer[offset + 2] = (value >>> 16) & 255),
                (this.buffer[offset + 1] = (value >>> 8) & 255),
                (this.buffer[offset] = value & 255))
              : ((this.buffer[offset] = (value >>> 24) & 255),
                (this.buffer[offset + 1] = (value >>> 16) & 255),
                (this.buffer[offset + 2] = (value >>> 8) & 255),
                (this.buffer[offset + 3] = value & 255)),
            relative && (this.offset += 4),
            this
          );
        }),
        (ByteBufferPrototype.writeInt = ByteBufferPrototype.writeInt32),
        (ByteBufferPrototype.readInt32 = function (offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 4 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+4) <= ' + this.buffer.length);
          }
          var value = 0;
          return (
            this.littleEndian
              ? ((value = this.buffer[offset + 2] << 16),
                (value |= this.buffer[offset + 1] << 8),
                (value |= this.buffer[offset]),
                (value += (this.buffer[offset + 3] << 24) >>> 0))
              : ((value = this.buffer[offset + 1] << 16),
                (value |= this.buffer[offset + 2] << 8),
                (value |= this.buffer[offset + 3]),
                (value += (this.buffer[offset] << 24) >>> 0)),
            (value |= 0),
            relative && (this.offset += 4),
            value
          );
        }),
        (ByteBufferPrototype.readInt = ByteBufferPrototype.readInt32),
        (ByteBufferPrototype.writeUint32 = function (value, offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof value != 'number' || value % 1 !== 0)
              throw TypeError('Illegal value: ' + value + ' (not an integer)');
            if (((value >>>= 0), typeof offset != 'number' || offset % 1 !== 0))
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
          }
          offset += 4;
          var capacity5 = this.buffer.length;
          return (
            offset > capacity5 && this.resize((capacity5 *= 2) > offset ? capacity5 : offset),
            (offset -= 4),
            this.littleEndian
              ? ((this.buffer[offset + 3] = (value >>> 24) & 255),
                (this.buffer[offset + 2] = (value >>> 16) & 255),
                (this.buffer[offset + 1] = (value >>> 8) & 255),
                (this.buffer[offset] = value & 255))
              : ((this.buffer[offset] = (value >>> 24) & 255),
                (this.buffer[offset + 1] = (value >>> 16) & 255),
                (this.buffer[offset + 2] = (value >>> 8) & 255),
                (this.buffer[offset + 3] = value & 255)),
            relative && (this.offset += 4),
            this
          );
        }),
        (ByteBufferPrototype.writeUInt32 = ByteBufferPrototype.writeUint32),
        (ByteBufferPrototype.readUint32 = function (offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 4 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+4) <= ' + this.buffer.length);
          }
          var value = 0;
          return (
            this.littleEndian
              ? ((value = this.buffer[offset + 2] << 16),
                (value |= this.buffer[offset + 1] << 8),
                (value |= this.buffer[offset]),
                (value += (this.buffer[offset + 3] << 24) >>> 0))
              : ((value = this.buffer[offset + 1] << 16),
                (value |= this.buffer[offset + 2] << 8),
                (value |= this.buffer[offset + 3]),
                (value += (this.buffer[offset] << 24) >>> 0)),
            relative && (this.offset += 4),
            value
          );
        }),
        (ByteBufferPrototype.readUInt32 = ByteBufferPrototype.readUint32),
        Long &&
          ((ByteBufferPrototype.writeInt64 = function (value, offset) {
            var relative = typeof offset > 'u';
            if ((relative && (offset = this.offset), !this.noAssert)) {
              if (typeof value == 'number') value = Long.fromNumber(value);
              else if (typeof value == 'string') value = Long.fromString(value);
              else if (!(value && value instanceof Long))
                throw TypeError('Illegal value: ' + value + ' (not an integer or Long)');
              if (typeof offset != 'number' || offset % 1 !== 0)
                throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
              if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
                throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
            }
            (typeof value == 'number'
              ? (value = Long.fromNumber(value))
              : typeof value == 'string' && (value = Long.fromString(value)),
              (offset += 8));
            var capacity6 = this.buffer.length;
            (offset > capacity6 && this.resize((capacity6 *= 2) > offset ? capacity6 : offset), (offset -= 8));
            var lo = value.low,
              hi = value.high;
            return (
              this.littleEndian
                ? ((this.buffer[offset + 3] = (lo >>> 24) & 255),
                  (this.buffer[offset + 2] = (lo >>> 16) & 255),
                  (this.buffer[offset + 1] = (lo >>> 8) & 255),
                  (this.buffer[offset] = lo & 255),
                  (offset += 4),
                  (this.buffer[offset + 3] = (hi >>> 24) & 255),
                  (this.buffer[offset + 2] = (hi >>> 16) & 255),
                  (this.buffer[offset + 1] = (hi >>> 8) & 255),
                  (this.buffer[offset] = hi & 255))
                : ((this.buffer[offset] = (hi >>> 24) & 255),
                  (this.buffer[offset + 1] = (hi >>> 16) & 255),
                  (this.buffer[offset + 2] = (hi >>> 8) & 255),
                  (this.buffer[offset + 3] = hi & 255),
                  (offset += 4),
                  (this.buffer[offset] = (lo >>> 24) & 255),
                  (this.buffer[offset + 1] = (lo >>> 16) & 255),
                  (this.buffer[offset + 2] = (lo >>> 8) & 255),
                  (this.buffer[offset + 3] = lo & 255)),
              relative && (this.offset += 8),
              this
            );
          }),
          (ByteBufferPrototype.writeLong = ByteBufferPrototype.writeInt64),
          (ByteBufferPrototype.readInt64 = function (offset) {
            var relative = typeof offset > 'u';
            if ((relative && (offset = this.offset), !this.noAssert)) {
              if (typeof offset != 'number' || offset % 1 !== 0)
                throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
              if (((offset >>>= 0), offset < 0 || offset + 8 > this.buffer.length))
                throw RangeError('Illegal offset: 0 <= ' + offset + ' (+8) <= ' + this.buffer.length);
            }
            var lo = 0,
              hi = 0;
            this.littleEndian
              ? ((lo = this.buffer[offset + 2] << 16),
                (lo |= this.buffer[offset + 1] << 8),
                (lo |= this.buffer[offset]),
                (lo += (this.buffer[offset + 3] << 24) >>> 0),
                (offset += 4),
                (hi = this.buffer[offset + 2] << 16),
                (hi |= this.buffer[offset + 1] << 8),
                (hi |= this.buffer[offset]),
                (hi += (this.buffer[offset + 3] << 24) >>> 0))
              : ((hi = this.buffer[offset + 1] << 16),
                (hi |= this.buffer[offset + 2] << 8),
                (hi |= this.buffer[offset + 3]),
                (hi += (this.buffer[offset] << 24) >>> 0),
                (offset += 4),
                (lo = this.buffer[offset + 1] << 16),
                (lo |= this.buffer[offset + 2] << 8),
                (lo |= this.buffer[offset + 3]),
                (lo += (this.buffer[offset] << 24) >>> 0));
            var value = new Long(lo, hi, !1);
            return (relative && (this.offset += 8), value);
          }),
          (ByteBufferPrototype.readLong = ByteBufferPrototype.readInt64),
          (ByteBufferPrototype.writeUint64 = function (value, offset) {
            var relative = typeof offset > 'u';
            if ((relative && (offset = this.offset), !this.noAssert)) {
              if (typeof value == 'number') value = Long.fromNumber(value);
              else if (typeof value == 'string') value = Long.fromString(value);
              else if (!(value && value instanceof Long))
                throw TypeError('Illegal value: ' + value + ' (not an integer or Long)');
              if (typeof offset != 'number' || offset % 1 !== 0)
                throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
              if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
                throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
            }
            (typeof value == 'number'
              ? (value = Long.fromNumber(value))
              : typeof value == 'string' && (value = Long.fromString(value)),
              (offset += 8));
            var capacity7 = this.buffer.length;
            (offset > capacity7 && this.resize((capacity7 *= 2) > offset ? capacity7 : offset), (offset -= 8));
            var lo = value.low,
              hi = value.high;
            return (
              this.littleEndian
                ? ((this.buffer[offset + 3] = (lo >>> 24) & 255),
                  (this.buffer[offset + 2] = (lo >>> 16) & 255),
                  (this.buffer[offset + 1] = (lo >>> 8) & 255),
                  (this.buffer[offset] = lo & 255),
                  (offset += 4),
                  (this.buffer[offset + 3] = (hi >>> 24) & 255),
                  (this.buffer[offset + 2] = (hi >>> 16) & 255),
                  (this.buffer[offset + 1] = (hi >>> 8) & 255),
                  (this.buffer[offset] = hi & 255))
                : ((this.buffer[offset] = (hi >>> 24) & 255),
                  (this.buffer[offset + 1] = (hi >>> 16) & 255),
                  (this.buffer[offset + 2] = (hi >>> 8) & 255),
                  (this.buffer[offset + 3] = hi & 255),
                  (offset += 4),
                  (this.buffer[offset] = (lo >>> 24) & 255),
                  (this.buffer[offset + 1] = (lo >>> 16) & 255),
                  (this.buffer[offset + 2] = (lo >>> 8) & 255),
                  (this.buffer[offset + 3] = lo & 255)),
              relative && (this.offset += 8),
              this
            );
          }),
          (ByteBufferPrototype.writeUInt64 = ByteBufferPrototype.writeUint64),
          (ByteBufferPrototype.readUint64 = function (offset) {
            var relative = typeof offset > 'u';
            if ((relative && (offset = this.offset), !this.noAssert)) {
              if (typeof offset != 'number' || offset % 1 !== 0)
                throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
              if (((offset >>>= 0), offset < 0 || offset + 8 > this.buffer.length))
                throw RangeError('Illegal offset: 0 <= ' + offset + ' (+8) <= ' + this.buffer.length);
            }
            var lo = 0,
              hi = 0;
            this.littleEndian
              ? ((lo = this.buffer[offset + 2] << 16),
                (lo |= this.buffer[offset + 1] << 8),
                (lo |= this.buffer[offset]),
                (lo += (this.buffer[offset + 3] << 24) >>> 0),
                (offset += 4),
                (hi = this.buffer[offset + 2] << 16),
                (hi |= this.buffer[offset + 1] << 8),
                (hi |= this.buffer[offset]),
                (hi += (this.buffer[offset + 3] << 24) >>> 0))
              : ((hi = this.buffer[offset + 1] << 16),
                (hi |= this.buffer[offset + 2] << 8),
                (hi |= this.buffer[offset + 3]),
                (hi += (this.buffer[offset] << 24) >>> 0),
                (offset += 4),
                (lo = this.buffer[offset + 1] << 16),
                (lo |= this.buffer[offset + 2] << 8),
                (lo |= this.buffer[offset + 3]),
                (lo += (this.buffer[offset] << 24) >>> 0));
            var value = new Long(lo, hi, !0);
            return (relative && (this.offset += 8), value);
          }),
          (ByteBufferPrototype.readUInt64 = ByteBufferPrototype.readUint64)),
        (ByteBufferPrototype.writeFloat32 = function (value, offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof value != 'number') throw TypeError('Illegal value: ' + value + ' (not a number)');
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
          }
          offset += 4;
          var capacity8 = this.buffer.length;
          return (
            offset > capacity8 && this.resize((capacity8 *= 2) > offset ? capacity8 : offset),
            (offset -= 4),
            this.littleEndian
              ? this.buffer.writeFloatLE(value, offset, !0)
              : this.buffer.writeFloatBE(value, offset, !0),
            relative && (this.offset += 4),
            this
          );
        }),
        (ByteBufferPrototype.writeFloat = ByteBufferPrototype.writeFloat32),
        (ByteBufferPrototype.readFloat32 = function (offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 4 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+4) <= ' + this.buffer.length);
          }
          var value = this.littleEndian ? this.buffer.readFloatLE(offset, !0) : this.buffer.readFloatBE(offset, !0);
          return (relative && (this.offset += 4), value);
        }),
        (ByteBufferPrototype.readFloat = ByteBufferPrototype.readFloat32),
        (ByteBufferPrototype.writeFloat64 = function (value, offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof value != 'number') throw TypeError('Illegal value: ' + value + ' (not a number)');
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
          }
          offset += 8;
          var capacity9 = this.buffer.length;
          return (
            offset > capacity9 && this.resize((capacity9 *= 2) > offset ? capacity9 : offset),
            (offset -= 8),
            this.littleEndian
              ? this.buffer.writeDoubleLE(value, offset, !0)
              : this.buffer.writeDoubleBE(value, offset, !0),
            relative && (this.offset += 8),
            this
          );
        }),
        (ByteBufferPrototype.writeDouble = ByteBufferPrototype.writeFloat64),
        (ByteBufferPrototype.readFloat64 = function (offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 8 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+8) <= ' + this.buffer.length);
          }
          var value = this.littleEndian ? this.buffer.readDoubleLE(offset, !0) : this.buffer.readDoubleBE(offset, !0);
          return (relative && (this.offset += 8), value);
        }),
        (ByteBufferPrototype.readDouble = ByteBufferPrototype.readFloat64),
        (ByteBuffer.MAX_VARINT32_BYTES = 5),
        (ByteBuffer.calculateVarint32 = function (value) {
          return (
            (value = value >>> 0),
            value < 128 ? 1 : value < 16384 ? 2 : value < 1 << 21 ? 3 : value < 1 << 28 ? 4 : 5
          );
        }),
        (ByteBuffer.zigZagEncode32 = function (n) {
          return (((n |= 0) << 1) ^ (n >> 31)) >>> 0;
        }),
        (ByteBuffer.zigZagDecode32 = function (n) {
          return ((n >>> 1) ^ -(n & 1)) | 0;
        }),
        (ByteBufferPrototype.writeVarint32 = function (value, offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof value != 'number' || value % 1 !== 0)
              throw TypeError('Illegal value: ' + value + ' (not an integer)');
            if (((value |= 0), typeof offset != 'number' || offset % 1 !== 0))
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
          }
          var size = ByteBuffer.calculateVarint32(value),
            b;
          offset += size;
          var capacity10 = this.buffer.length;
          for (
            offset > capacity10 && this.resize((capacity10 *= 2) > offset ? capacity10 : offset),
              offset -= size,
              value >>>= 0;
            value >= 128;
          )
            ((b = (value & 127) | 128), (this.buffer[offset++] = b), (value >>>= 7));
          return ((this.buffer[offset++] = value), relative ? ((this.offset = offset), this) : size);
        }),
        (ByteBufferPrototype.writeVarint32ZigZag = function (value, offset) {
          return this.writeVarint32(ByteBuffer.zigZagEncode32(value), offset);
        }),
        (ByteBufferPrototype.readVarint32 = function (offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 1 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+1) <= ' + this.buffer.length);
          }
          var c = 0,
            value = 0,
            b;
          do {
            if (!this.noAssert && offset > this.limit) {
              var err = Error('Truncated');
              throw ((err.truncated = !0), err);
            }
            ((b = this.buffer[offset++]), c < 5 && (value |= (b & 127) << (7 * c)), ++c);
          } while ((b & 128) !== 0);
          return ((value |= 0), relative ? ((this.offset = offset), value) : { value, length: c });
        }),
        (ByteBufferPrototype.readVarint32ZigZag = function (offset) {
          var val = this.readVarint32(offset);
          return (
            typeof val == 'object'
              ? (val.value = ByteBuffer.zigZagDecode32(val.value))
              : (val = ByteBuffer.zigZagDecode32(val)),
            val
          );
        }),
        Long &&
          ((ByteBuffer.MAX_VARINT64_BYTES = 10),
          (ByteBuffer.calculateVarint64 = function (value) {
            typeof value == 'number'
              ? (value = Long.fromNumber(value))
              : typeof value == 'string' && (value = Long.fromString(value));
            var part0 = value.toInt() >>> 0,
              part1 = value.shiftRightUnsigned(28).toInt() >>> 0,
              part2 = value.shiftRightUnsigned(56).toInt() >>> 0;
            return part2 == 0
              ? part1 == 0
                ? part0 < 16384
                  ? part0 < 128
                    ? 1
                    : 2
                  : part0 < 1 << 21
                    ? 3
                    : 4
                : part1 < 16384
                  ? part1 < 128
                    ? 5
                    : 6
                  : part1 < 1 << 21
                    ? 7
                    : 8
              : part2 < 128
                ? 9
                : 10;
          }),
          (ByteBuffer.zigZagEncode64 = function (value) {
            return (
              typeof value == 'number'
                ? (value = Long.fromNumber(value, !1))
                : typeof value == 'string'
                  ? (value = Long.fromString(value, !1))
                  : value.unsigned !== !1 && (value = value.toSigned()),
              value.shiftLeft(1).xor(value.shiftRight(63)).toUnsigned()
            );
          }),
          (ByteBuffer.zigZagDecode64 = function (value) {
            return (
              typeof value == 'number'
                ? (value = Long.fromNumber(value, !1))
                : typeof value == 'string'
                  ? (value = Long.fromString(value, !1))
                  : value.unsigned !== !1 && (value = value.toSigned()),
              value.shiftRightUnsigned(1).xor(value.and(Long.ONE).toSigned().negate()).toSigned()
            );
          }),
          (ByteBufferPrototype.writeVarint64 = function (value, offset) {
            var relative = typeof offset > 'u';
            if ((relative && (offset = this.offset), !this.noAssert)) {
              if (typeof value == 'number') value = Long.fromNumber(value);
              else if (typeof value == 'string') value = Long.fromString(value);
              else if (!(value && value instanceof Long))
                throw TypeError('Illegal value: ' + value + ' (not an integer or Long)');
              if (typeof offset != 'number' || offset % 1 !== 0)
                throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
              if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
                throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
            }
            typeof value == 'number'
              ? (value = Long.fromNumber(value, !1))
              : typeof value == 'string'
                ? (value = Long.fromString(value, !1))
                : value.unsigned !== !1 && (value = value.toSigned());
            var size = ByteBuffer.calculateVarint64(value),
              part0 = value.toInt() >>> 0,
              part1 = value.shiftRightUnsigned(28).toInt() >>> 0,
              part2 = value.shiftRightUnsigned(56).toInt() >>> 0;
            offset += size;
            var capacity11 = this.buffer.length;
            switch (
              (offset > capacity11 && this.resize((capacity11 *= 2) > offset ? capacity11 : offset),
              (offset -= size),
              size)
            ) {
              case 10:
                this.buffer[offset + 9] = (part2 >>> 7) & 1;
              case 9:
                this.buffer[offset + 8] = size !== 9 ? part2 | 128 : part2 & 127;
              case 8:
                this.buffer[offset + 7] = size !== 8 ? (part1 >>> 21) | 128 : (part1 >>> 21) & 127;
              case 7:
                this.buffer[offset + 6] = size !== 7 ? (part1 >>> 14) | 128 : (part1 >>> 14) & 127;
              case 6:
                this.buffer[offset + 5] = size !== 6 ? (part1 >>> 7) | 128 : (part1 >>> 7) & 127;
              case 5:
                this.buffer[offset + 4] = size !== 5 ? part1 | 128 : part1 & 127;
              case 4:
                this.buffer[offset + 3] = size !== 4 ? (part0 >>> 21) | 128 : (part0 >>> 21) & 127;
              case 3:
                this.buffer[offset + 2] = size !== 3 ? (part0 >>> 14) | 128 : (part0 >>> 14) & 127;
              case 2:
                this.buffer[offset + 1] = size !== 2 ? (part0 >>> 7) | 128 : (part0 >>> 7) & 127;
              case 1:
                this.buffer[offset] = size !== 1 ? part0 | 128 : part0 & 127;
            }
            return relative ? ((this.offset += size), this) : size;
          }),
          (ByteBufferPrototype.writeVarint64ZigZag = function (value, offset) {
            return this.writeVarint64(ByteBuffer.zigZagEncode64(value), offset);
          }),
          (ByteBufferPrototype.readVarint64 = function (offset) {
            var relative = typeof offset > 'u';
            if ((relative && (offset = this.offset), !this.noAssert)) {
              if (typeof offset != 'number' || offset % 1 !== 0)
                throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
              if (((offset >>>= 0), offset < 0 || offset + 1 > this.buffer.length))
                throw RangeError('Illegal offset: 0 <= ' + offset + ' (+1) <= ' + this.buffer.length);
            }
            var start = offset,
              part0 = 0,
              part1 = 0,
              part2 = 0,
              b = 0;
            if (
              ((b = this.buffer[offset++]),
              (part0 = b & 127),
              b & 128 &&
                ((b = this.buffer[offset++]),
                (part0 |= (b & 127) << 7),
                (b & 128 || (this.noAssert && typeof b > 'u')) &&
                  ((b = this.buffer[offset++]),
                  (part0 |= (b & 127) << 14),
                  (b & 128 || (this.noAssert && typeof b > 'u')) &&
                    ((b = this.buffer[offset++]),
                    (part0 |= (b & 127) << 21),
                    (b & 128 || (this.noAssert && typeof b > 'u')) &&
                      ((b = this.buffer[offset++]),
                      (part1 = b & 127),
                      (b & 128 || (this.noAssert && typeof b > 'u')) &&
                        ((b = this.buffer[offset++]),
                        (part1 |= (b & 127) << 7),
                        (b & 128 || (this.noAssert && typeof b > 'u')) &&
                          ((b = this.buffer[offset++]),
                          (part1 |= (b & 127) << 14),
                          (b & 128 || (this.noAssert && typeof b > 'u')) &&
                            ((b = this.buffer[offset++]),
                            (part1 |= (b & 127) << 21),
                            (b & 128 || (this.noAssert && typeof b > 'u')) &&
                              ((b = this.buffer[offset++]),
                              (part2 = b & 127),
                              (b & 128 || (this.noAssert && typeof b > 'u')) &&
                                ((b = this.buffer[offset++]),
                                (part2 |= (b & 127) << 7),
                                b & 128 || (this.noAssert && typeof b > 'u')))))))))))
            )
              throw Error('Buffer overrun');
            var value = Long.fromBits(part0 | (part1 << 28), (part1 >>> 4) | (part2 << 24), !1);
            return relative ? ((this.offset = offset), value) : { value, length: offset - start };
          }),
          (ByteBufferPrototype.readVarint64ZigZag = function (offset) {
            var val = this.readVarint64(offset);
            return (
              val && val.value instanceof Long
                ? (val.value = ByteBuffer.zigZagDecode64(val.value))
                : (val = ByteBuffer.zigZagDecode64(val)),
              val
            );
          })),
        (ByteBufferPrototype.writeCString = function (str, offset) {
          var relative = typeof offset > 'u';
          relative && (offset = this.offset);
          var i,
            k = str.length;
          if (!this.noAssert) {
            if (typeof str != 'string') throw TypeError('Illegal str: Not a string');
            for (i = 0; i < k; ++i)
              if (str.charCodeAt(i) === 0) throw RangeError('Illegal str: Contains NULL-characters');
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
          }
          ((k = Buffer2.byteLength(str, 'utf8')), (offset += k + 1));
          var capacity12 = this.buffer.length;
          return (
            offset > capacity12 && this.resize((capacity12 *= 2) > offset ? capacity12 : offset),
            (offset -= k + 1),
            (offset += this.buffer.write(str, offset, k, 'utf8')),
            (this.buffer[offset++] = 0),
            relative ? ((this.offset = offset), this) : k
          );
        }),
        (ByteBufferPrototype.readCString = function (offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 1 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+1) <= ' + this.buffer.length);
          }
          var start = offset,
            temp;
          do {
            if (offset >= this.buffer.length)
              throw RangeError('Index out of range: ' + offset + ' <= ' + this.buffer.length);
            temp = this.buffer[offset++];
          } while (temp !== 0);
          var str = this.buffer.toString('utf8', start, offset - 1);
          return relative ? ((this.offset = offset), str) : { string: str, length: offset - start };
        }),
        (ByteBufferPrototype.writeIString = function (str, offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof str != 'string') throw TypeError('Illegal str: Not a string');
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
          }
          var start = offset,
            k;
          ((k = Buffer2.byteLength(str, 'utf8')), (offset += 4 + k));
          var capacity13 = this.buffer.length;
          return (
            offset > capacity13 && this.resize((capacity13 *= 2) > offset ? capacity13 : offset),
            (offset -= 4 + k),
            this.littleEndian
              ? ((this.buffer[offset + 3] = (k >>> 24) & 255),
                (this.buffer[offset + 2] = (k >>> 16) & 255),
                (this.buffer[offset + 1] = (k >>> 8) & 255),
                (this.buffer[offset] = k & 255))
              : ((this.buffer[offset] = (k >>> 24) & 255),
                (this.buffer[offset + 1] = (k >>> 16) & 255),
                (this.buffer[offset + 2] = (k >>> 8) & 255),
                (this.buffer[offset + 3] = k & 255)),
            (offset += 4),
            (offset += this.buffer.write(str, offset, k, 'utf8')),
            relative ? ((this.offset = offset), this) : offset - start
          );
        }),
        (ByteBufferPrototype.readIString = function (offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 4 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+4) <= ' + this.buffer.length);
          }
          var start = offset,
            len = this.readUint32(offset),
            str = this.readUTF8String(len, ByteBuffer.METRICS_BYTES, (offset += 4));
          return (
            (offset += str.length),
            relative ? ((this.offset = offset), str.string) : { string: str.string, length: offset - start }
          );
        }),
        (ByteBuffer.METRICS_CHARS = 'c'),
        (ByteBuffer.METRICS_BYTES = 'b'),
        (ByteBufferPrototype.writeUTF8String = function (str, offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
          }
          var k;
          ((k = Buffer2.byteLength(str, 'utf8')), (offset += k));
          var capacity14 = this.buffer.length;
          return (
            offset > capacity14 && this.resize((capacity14 *= 2) > offset ? capacity14 : offset),
            (offset -= k),
            (offset += this.buffer.write(str, offset, k, 'utf8')),
            relative ? ((this.offset = offset), this) : k
          );
        }),
        (ByteBufferPrototype.writeString = ByteBufferPrototype.writeUTF8String),
        (ByteBuffer.calculateUTF8Chars = function (str) {
          return utfx.calculateUTF16asUTF8(stringSource(str))[0];
        }),
        (ByteBuffer.calculateUTF8Bytes = function (str) {
          if (typeof str != 'string') throw TypeError('Illegal argument: ' + typeof str);
          return Buffer2.byteLength(str, 'utf8');
        }),
        (ByteBuffer.calculateString = ByteBuffer.calculateUTF8Bytes),
        (ByteBufferPrototype.readUTF8String = function (length, metrics, offset) {
          typeof metrics == 'number' && ((offset = metrics), (metrics = void 0));
          var relative = typeof offset > 'u';
          if (
            (relative && (offset = this.offset),
            typeof metrics > 'u' && (metrics = ByteBuffer.METRICS_CHARS),
            !this.noAssert)
          ) {
            if (typeof length != 'number' || length % 1 !== 0)
              throw TypeError('Illegal length: ' + length + ' (not an integer)');
            if (((length |= 0), typeof offset != 'number' || offset % 1 !== 0))
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
          }
          var i = 0,
            start = offset,
            temp,
            sd;
          if (metrics === ByteBuffer.METRICS_CHARS) {
            if (
              ((sd = stringDestination()),
              utfx.decodeUTF8(
                function () {
                  return i < length && offset < this.limit ? this.buffer[offset++] : null;
                }.bind(this),
                function (cp) {
                  (++i, utfx.UTF8toUTF16(cp, sd));
                }
              ),
              i !== length)
            )
              throw RangeError('Illegal range: Truncated data, ' + i + ' == ' + length);
            return relative ? ((this.offset = offset), sd()) : { string: sd(), length: offset - start };
          } else if (metrics === ByteBuffer.METRICS_BYTES) {
            if (!this.noAssert) {
              if (typeof offset != 'number' || offset % 1 !== 0)
                throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
              if (((offset >>>= 0), offset < 0 || offset + length > this.buffer.length))
                throw RangeError('Illegal offset: 0 <= ' + offset + ' (+' + length + ') <= ' + this.buffer.length);
            }
            return (
              (temp = this.buffer.toString('utf8', offset, offset + length)),
              relative ? ((this.offset += length), temp) : { string: temp, length }
            );
          } else throw TypeError('Unsupported metrics: ' + metrics);
        }),
        (ByteBufferPrototype.readString = ByteBufferPrototype.readUTF8String),
        (ByteBufferPrototype.writeVString = function (str, offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof str != 'string') throw TypeError('Illegal str: Not a string');
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
          }
          var start = offset,
            k,
            l;
          ((k = Buffer2.byteLength(str, 'utf8')), (l = ByteBuffer.calculateVarint32(k)), (offset += l + k));
          var capacity15 = this.buffer.length;
          return (
            offset > capacity15 && this.resize((capacity15 *= 2) > offset ? capacity15 : offset),
            (offset -= l + k),
            (offset += this.writeVarint32(k, offset)),
            (offset += this.buffer.write(str, offset, k, 'utf8')),
            relative ? ((this.offset = offset), this) : offset - start
          );
        }),
        (ByteBufferPrototype.readVString = function (offset) {
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 1 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+1) <= ' + this.buffer.length);
          }
          var start = offset,
            len = this.readVarint32(offset),
            str = this.readUTF8String(len.value, ByteBuffer.METRICS_BYTES, (offset += len.length));
          return (
            (offset += str.length),
            relative ? ((this.offset = offset), str.string) : { string: str.string, length: offset - start }
          );
        }),
        (ByteBufferPrototype.append = function (source, encoding, offset) {
          (typeof encoding == 'number' || typeof encoding != 'string') && ((offset = encoding), (encoding = void 0));
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
          }
          source instanceof ByteBuffer || (source = ByteBuffer.wrap(source, encoding));
          var length = source.limit - source.offset;
          if (length <= 0) return this;
          offset += length;
          var capacity16 = this.buffer.length;
          return (
            offset > capacity16 && this.resize((capacity16 *= 2) > offset ? capacity16 : offset),
            (offset -= length),
            source.buffer.copy(this.buffer, offset, source.offset, source.limit),
            (source.offset += length),
            relative && (this.offset += length),
            this
          );
        }),
        (ByteBufferPrototype.appendTo = function (target, offset) {
          return (target.append(this, offset), this);
        }),
        (ByteBufferPrototype.assert = function (assert) {
          return ((this.noAssert = !assert), this);
        }),
        (ByteBufferPrototype.capacity = function () {
          return this.buffer.length;
        }),
        (ByteBufferPrototype.clear = function () {
          return ((this.offset = 0), (this.limit = this.buffer.length), (this.markedOffset = -1), this);
        }),
        (ByteBufferPrototype.clone = function (copy) {
          var bb2 = new ByteBuffer(0, this.littleEndian, this.noAssert);
          if (copy) {
            var buffer2 = Buffer2.allocUnsafe(this.buffer.length);
            (this.buffer.copy(buffer2), (bb2.buffer = buffer2));
          } else bb2.buffer = this.buffer;
          return ((bb2.offset = this.offset), (bb2.markedOffset = this.markedOffset), (bb2.limit = this.limit), bb2);
        }),
        (ByteBufferPrototype.compact = function (begin, end) {
          if ((typeof begin > 'u' && (begin = this.offset), typeof end > 'u' && (end = this.limit), !this.noAssert)) {
            if (typeof begin != 'number' || begin % 1 !== 0) throw TypeError('Illegal begin: Not an integer');
            if (((begin >>>= 0), typeof end != 'number' || end % 1 !== 0))
              throw TypeError('Illegal end: Not an integer');
            if (((end >>>= 0), begin < 0 || begin > end || end > this.buffer.length))
              throw RangeError('Illegal range: 0 <= ' + begin + ' <= ' + end + ' <= ' + this.buffer.length);
          }
          if (begin === 0 && end === this.buffer.length) return this;
          var len = end - begin;
          if (len === 0)
            return (
              (this.buffer = EMPTY_BUFFER),
              this.markedOffset >= 0 && (this.markedOffset -= begin),
              (this.offset = 0),
              (this.limit = 0),
              this
            );
          var buffer2 = Buffer2.allocUnsafe(len);
          return (
            this.buffer.copy(buffer2, 0, begin, end),
            (this.buffer = buffer2),
            this.markedOffset >= 0 && (this.markedOffset -= begin),
            (this.offset = 0),
            (this.limit = len),
            this
          );
        }),
        (ByteBufferPrototype.copy = function (begin, end) {
          if ((typeof begin > 'u' && (begin = this.offset), typeof end > 'u' && (end = this.limit), !this.noAssert)) {
            if (typeof begin != 'number' || begin % 1 !== 0) throw TypeError('Illegal begin: Not an integer');
            if (((begin >>>= 0), typeof end != 'number' || end % 1 !== 0))
              throw TypeError('Illegal end: Not an integer');
            if (((end >>>= 0), begin < 0 || begin > end || end > this.buffer.length))
              throw RangeError('Illegal range: 0 <= ' + begin + ' <= ' + end + ' <= ' + this.buffer.length);
          }
          if (begin === end) return new ByteBuffer(0, this.littleEndian, this.noAssert);
          var capacity = end - begin,
            bb2 = new ByteBuffer(capacity, this.littleEndian, this.noAssert);
          return (
            (bb2.offset = 0),
            (bb2.limit = capacity),
            bb2.markedOffset >= 0 && (bb2.markedOffset -= begin),
            this.copyTo(bb2, 0, begin, end),
            bb2
          );
        }),
        (ByteBufferPrototype.copyTo = function (target, targetOffset, sourceOffset, sourceLimit) {
          var relative, targetRelative;
          if (!this.noAssert && !ByteBuffer.isByteBuffer(target)) throw TypeError('Illegal target: Not a ByteBuffer');
          if (
            ((targetOffset = (targetRelative = typeof targetOffset > 'u') ? target.offset : targetOffset | 0),
            (sourceOffset = (relative = typeof sourceOffset > 'u') ? this.offset : sourceOffset | 0),
            (sourceLimit = typeof sourceLimit > 'u' ? this.limit : sourceLimit | 0),
            targetOffset < 0 || targetOffset > target.buffer.length)
          )
            throw RangeError('Illegal target range: 0 <= ' + targetOffset + ' <= ' + target.buffer.length);
          if (sourceOffset < 0 || sourceLimit > this.buffer.length)
            throw RangeError('Illegal source range: 0 <= ' + sourceOffset + ' <= ' + this.buffer.length);
          var len = sourceLimit - sourceOffset;
          return len === 0
            ? target
            : (target.ensureCapacity(targetOffset + len),
              this.buffer.copy(target.buffer, targetOffset, sourceOffset, sourceLimit),
              relative && (this.offset += len),
              targetRelative && (target.offset += len),
              this);
        }),
        (ByteBufferPrototype.ensureCapacity = function (capacity) {
          var current = this.buffer.length;
          return current < capacity ? this.resize((current *= 2) > capacity ? current : capacity) : this;
        }),
        (ByteBufferPrototype.fill = function (value, begin, end) {
          var relative = typeof begin > 'u';
          if (
            (relative && (begin = this.offset),
            typeof value == 'string' && value.length > 0 && (value = value.charCodeAt(0)),
            typeof begin > 'u' && (begin = this.offset),
            typeof end > 'u' && (end = this.limit),
            !this.noAssert)
          ) {
            if (typeof value != 'number' || value % 1 !== 0)
              throw TypeError('Illegal value: ' + value + ' (not an integer)');
            if (((value |= 0), typeof begin != 'number' || begin % 1 !== 0))
              throw TypeError('Illegal begin: Not an integer');
            if (((begin >>>= 0), typeof end != 'number' || end % 1 !== 0))
              throw TypeError('Illegal end: Not an integer');
            if (((end >>>= 0), begin < 0 || begin > end || end > this.buffer.length))
              throw RangeError('Illegal range: 0 <= ' + begin + ' <= ' + end + ' <= ' + this.buffer.length);
          }
          return begin >= end
            ? this
            : (this.buffer.fill(value, begin, end), (begin = end), relative && (this.offset = begin), this);
        }),
        (ByteBufferPrototype.flip = function () {
          return ((this.limit = this.offset), (this.offset = 0), this);
        }),
        (ByteBufferPrototype.mark = function (offset) {
          if (((offset = typeof offset > 'u' ? this.offset : offset), !this.noAssert)) {
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
          }
          return ((this.markedOffset = offset), this);
        }),
        (ByteBufferPrototype.order = function (littleEndian) {
          if (!this.noAssert && typeof littleEndian != 'boolean')
            throw TypeError('Illegal littleEndian: Not a boolean');
          return ((this.littleEndian = !!littleEndian), this);
        }),
        (ByteBufferPrototype.LE = function (littleEndian) {
          return ((this.littleEndian = typeof littleEndian < 'u' ? !!littleEndian : !0), this);
        }),
        (ByteBufferPrototype.BE = function (bigEndian) {
          return ((this.littleEndian = typeof bigEndian < 'u' ? !bigEndian : !1), this);
        }),
        (ByteBufferPrototype.prepend = function (source, encoding, offset) {
          (typeof encoding == 'number' || typeof encoding != 'string') && ((offset = encoding), (encoding = void 0));
          var relative = typeof offset > 'u';
          if ((relative && (offset = this.offset), !this.noAssert)) {
            if (typeof offset != 'number' || offset % 1 !== 0)
              throw TypeError('Illegal offset: ' + offset + ' (not an integer)');
            if (((offset >>>= 0), offset < 0 || offset + 0 > this.buffer.length))
              throw RangeError('Illegal offset: 0 <= ' + offset + ' (+0) <= ' + this.buffer.length);
          }
          source instanceof ByteBuffer || (source = ByteBuffer.wrap(source, encoding));
          var len = source.limit - source.offset;
          if (len <= 0) return this;
          var diff = len - offset;
          if (diff > 0) {
            var buffer2 = Buffer2.allocUnsafe(this.buffer.length + diff);
            (this.buffer.copy(buffer2, len, offset, this.buffer.length),
              (this.buffer = buffer2),
              (this.offset += diff),
              this.markedOffset >= 0 && (this.markedOffset += diff),
              (this.limit += diff),
              (offset += diff));
          }
          return (
            source.buffer.copy(this.buffer, offset - len, source.offset, source.limit),
            (source.offset = source.limit),
            relative && (this.offset -= len),
            this
          );
        }),
        (ByteBufferPrototype.prependTo = function (target, offset) {
          return (target.prepend(this, offset), this);
        }),
        (ByteBufferPrototype.printDebug = function (out) {
          (typeof out != 'function' && (out = console.log.bind(console)),
            out(
              this.toString() +
                `
-------------------------------------------------------------------
` +
                this.toDebug(!0)
            ));
        }),
        (ByteBufferPrototype.remaining = function () {
          return this.limit - this.offset;
        }),
        (ByteBufferPrototype.reset = function () {
          return (
            this.markedOffset >= 0 ? ((this.offset = this.markedOffset), (this.markedOffset = -1)) : (this.offset = 0),
            this
          );
        }),
        (ByteBufferPrototype.resize = function (capacity) {
          if (!this.noAssert) {
            if (typeof capacity != 'number' || capacity % 1 !== 0)
              throw TypeError('Illegal capacity: ' + capacity + ' (not an integer)');
            if (((capacity |= 0), capacity < 0)) throw RangeError('Illegal capacity: 0 <= ' + capacity);
          }
          if (this.buffer.length < capacity) {
            var buffer2 = Buffer2.allocUnsafe(capacity);
            (this.buffer.copy(buffer2), (this.buffer = buffer2));
          }
          return this;
        }),
        (ByteBufferPrototype.reverse = function (begin, end) {
          if ((typeof begin > 'u' && (begin = this.offset), typeof end > 'u' && (end = this.limit), !this.noAssert)) {
            if (typeof begin != 'number' || begin % 1 !== 0) throw TypeError('Illegal begin: Not an integer');
            if (((begin >>>= 0), typeof end != 'number' || end % 1 !== 0))
              throw TypeError('Illegal end: Not an integer');
            if (((end >>>= 0), begin < 0 || begin > end || end > this.buffer.length))
              throw RangeError('Illegal range: 0 <= ' + begin + ' <= ' + end + ' <= ' + this.buffer.length);
          }
          return begin === end ? this : (Array.prototype.reverse.call(this.buffer.slice(begin, end)), this);
        }),
        (ByteBufferPrototype.skip = function (length) {
          if (!this.noAssert) {
            if (typeof length != 'number' || length % 1 !== 0)
              throw TypeError('Illegal length: ' + length + ' (not an integer)');
            length |= 0;
          }
          var offset = this.offset + length;
          if (!this.noAssert && (offset < 0 || offset > this.buffer.length))
            throw RangeError('Illegal length: 0 <= ' + this.offset + ' + ' + length + ' <= ' + this.buffer.length);
          return ((this.offset = offset), this);
        }),
        (ByteBufferPrototype.slice = function (begin, end) {
          if ((typeof begin > 'u' && (begin = this.offset), typeof end > 'u' && (end = this.limit), !this.noAssert)) {
            if (typeof begin != 'number' || begin % 1 !== 0) throw TypeError('Illegal begin: Not an integer');
            if (((begin >>>= 0), typeof end != 'number' || end % 1 !== 0))
              throw TypeError('Illegal end: Not an integer');
            if (((end >>>= 0), begin < 0 || begin > end || end > this.buffer.length))
              throw RangeError('Illegal range: 0 <= ' + begin + ' <= ' + end + ' <= ' + this.buffer.length);
          }
          var bb2 = this.clone();
          return ((bb2.offset = begin), (bb2.limit = end), bb2);
        }),
        (ByteBufferPrototype.toBuffer = function (forceCopy) {
          var offset = this.offset,
            limit = this.limit;
          if (!this.noAssert) {
            if (typeof offset != 'number' || offset % 1 !== 0) throw TypeError('Illegal offset: Not an integer');
            if (((offset >>>= 0), typeof limit != 'number' || limit % 1 !== 0))
              throw TypeError('Illegal limit: Not an integer');
            if (((limit >>>= 0), offset < 0 || offset > limit || limit > this.buffer.length))
              throw RangeError('Illegal range: 0 <= ' + offset + ' <= ' + limit + ' <= ' + this.buffer.length);
          }
          if (forceCopy) {
            var buffer2 = Buffer2.allocUnsafe(limit - offset);
            return (this.buffer.copy(buffer2, 0, offset, limit), buffer2);
          } else return offset === 0 && limit === this.buffer.length ? this.buffer : this.buffer.slice(offset, limit);
        }),
        (ByteBufferPrototype.toArrayBuffer = function () {
          var offset = this.offset,
            limit = this.limit;
          if (!this.noAssert) {
            if (typeof offset != 'number' || offset % 1 !== 0) throw TypeError('Illegal offset: Not an integer');
            if (((offset >>>= 0), typeof limit != 'number' || limit % 1 !== 0))
              throw TypeError('Illegal limit: Not an integer');
            if (((limit >>>= 0), offset < 0 || offset > limit || limit > this.buffer.length))
              throw RangeError('Illegal range: 0 <= ' + offset + ' <= ' + limit + ' <= ' + this.buffer.length);
          }
          var ab = new ArrayBuffer(limit - offset);
          if (memcpy) memcpy(ab, 0, this.buffer, offset, limit);
          else for (var dst = new Uint8Array(ab), i = offset; i < limit; ++i) dst[i - offset] = this.buffer[i];
          return ab;
        }),
        (ByteBufferPrototype.toString = function (encoding, begin, end) {
          if (typeof encoding > 'u')
            return (
              'ByteBufferNB(offset=' +
              this.offset +
              ',markedOffset=' +
              this.markedOffset +
              ',limit=' +
              this.limit +
              ',capacity=' +
              this.capacity() +
              ')'
            );
          switch ((typeof encoding == 'number' && ((encoding = 'utf8'), (begin = encoding), (end = begin)), encoding)) {
            case 'utf8':
              return this.toUTF8(begin, end);
            case 'base64':
              return this.toBase64(begin, end);
            case 'hex':
              return this.toHex(begin, end);
            case 'binary':
              return this.toBinary(begin, end);
            case 'debug':
              return this.toDebug();
            case 'columns':
              return this.toColumns();
            default:
              throw Error('Unsupported encoding: ' + encoding);
          }
        }),
        (ByteBufferPrototype.toBase64 = function (begin, end) {
          if (
            (typeof begin > 'u' && (begin = this.offset),
            typeof end > 'u' && (end = this.limit),
            (begin = begin | 0),
            (end = end | 0),
            begin < 0 || end > this.capacity || begin > end)
          )
            throw RangeError('begin, end');
          return this.buffer.toString('base64', begin, end);
        }),
        (ByteBuffer.fromBase64 = function (str, littleEndian) {
          return ByteBuffer.wrap(Buffer2.from(str, 'base64'), littleEndian);
        }),
        (ByteBuffer.btoa = function (str) {
          return ByteBuffer.fromBinary(str).toBase64();
        }),
        (ByteBuffer.atob = function (b64) {
          return ByteBuffer.fromBase64(b64).toBinary();
        }),
        (ByteBufferPrototype.toBinary = function (begin, end) {
          if (
            (typeof begin > 'u' && (begin = this.offset),
            typeof end > 'u' && (end = this.limit),
            (begin |= 0),
            (end |= 0),
            begin < 0 || end > this.capacity() || begin > end)
          )
            throw RangeError('begin, end');
          return this.buffer.toString('binary', begin, end);
        }),
        (ByteBuffer.fromBinary = function (str, littleEndian) {
          return ByteBuffer.wrap(Buffer2.from(str, 'binary'), littleEndian);
        }),
        (ByteBufferPrototype.toDebug = function (columns) {
          for (var i = -1, k = this.buffer.length, b, hex = '', asc = '', out = ''; i < k; ) {
            if (
              (i !== -1 &&
                ((b = this.buffer[i]),
                b < 16 ? (hex += '0' + b.toString(16).toUpperCase()) : (hex += b.toString(16).toUpperCase()),
                columns && (asc += b > 32 && b < 127 ? String.fromCharCode(b) : '.')),
              ++i,
              columns && i > 0 && i % 16 === 0 && i !== k)
            ) {
              for (; hex.length < 51; ) hex += ' ';
              ((out +=
                hex +
                asc +
                `
`),
                (hex = asc = ''));
            }
            i === this.offset && i === this.limit
              ? (hex += i === this.markedOffset ? '!' : '|')
              : i === this.offset
                ? (hex += i === this.markedOffset ? '[' : '<')
                : i === this.limit
                  ? (hex += i === this.markedOffset ? ']' : '>')
                  : (hex += i === this.markedOffset ? "'" : columns || (i !== 0 && i !== k) ? ' ' : '');
          }
          if (columns && hex !== ' ') {
            for (; hex.length < 51; ) hex += ' ';
            out +=
              hex +
              asc +
              `
`;
          }
          return columns ? out : hex;
        }),
        (ByteBuffer.fromDebug = function (str, littleEndian, noAssert) {
          for (
            var k = str.length,
              bb2 = new ByteBuffer(((k + 1) / 3) | 0, littleEndian, noAssert),
              i = 0,
              j = 0,
              ch,
              b,
              rs = !1,
              ho = !1,
              hm = !1,
              hl = !1,
              fail = !1;
            i < k;
          ) {
            switch ((ch = str.charAt(i++))) {
              case '!':
                if (!noAssert) {
                  if (ho || hm || hl) {
                    fail = !0;
                    break;
                  }
                  ho = hm = hl = !0;
                }
                ((bb2.offset = bb2.markedOffset = bb2.limit = j), (rs = !1));
                break;
              case '|':
                if (!noAssert) {
                  if (ho || hl) {
                    fail = !0;
                    break;
                  }
                  ho = hl = !0;
                }
                ((bb2.offset = bb2.limit = j), (rs = !1));
                break;
              case '[':
                if (!noAssert) {
                  if (ho || hm) {
                    fail = !0;
                    break;
                  }
                  ho = hm = !0;
                }
                ((bb2.offset = bb2.markedOffset = j), (rs = !1));
                break;
              case '<':
                if (!noAssert) {
                  if (ho) {
                    fail = !0;
                    break;
                  }
                  ho = !0;
                }
                ((bb2.offset = j), (rs = !1));
                break;
              case ']':
                if (!noAssert) {
                  if (hl || hm) {
                    fail = !0;
                    break;
                  }
                  hl = hm = !0;
                }
                ((bb2.limit = bb2.markedOffset = j), (rs = !1));
                break;
              case '>':
                if (!noAssert) {
                  if (hl) {
                    fail = !0;
                    break;
                  }
                  hl = !0;
                }
                ((bb2.limit = j), (rs = !1));
                break;
              case "'":
                if (!noAssert) {
                  if (hm) {
                    fail = !0;
                    break;
                  }
                  hm = !0;
                }
                ((bb2.markedOffset = j), (rs = !1));
                break;
              case ' ':
                rs = !1;
                break;
              default:
                if (!noAssert && rs) {
                  fail = !0;
                  break;
                }
                if (((b = parseInt(ch + str.charAt(i++), 16)), !noAssert && (isNaN(b) || b < 0 || b > 255)))
                  throw TypeError('Illegal str: Not a debug encoded string');
                ((bb2.buffer[j++] = b), (rs = !0));
            }
            if (fail) throw TypeError('Illegal str: Invalid symbol at ' + i);
          }
          if (!noAssert) {
            if (!ho || !hl) throw TypeError('Illegal str: Missing offset or limit');
            if (j < bb2.buffer.length)
              throw TypeError('Illegal str: Not a debug encoded string (is it hex?) ' + j + ' < ' + k);
          }
          return bb2;
        }),
        (ByteBufferPrototype.toHex = function (begin, end) {
          if (
            ((begin = typeof begin > 'u' ? this.offset : begin),
            (end = typeof end > 'u' ? this.limit : end),
            !this.noAssert)
          ) {
            if (typeof begin != 'number' || begin % 1 !== 0) throw TypeError('Illegal begin: Not an integer');
            if (((begin >>>= 0), typeof end != 'number' || end % 1 !== 0))
              throw TypeError('Illegal end: Not an integer');
            if (((end >>>= 0), begin < 0 || begin > end || end > this.buffer.length))
              throw RangeError('Illegal range: 0 <= ' + begin + ' <= ' + end + ' <= ' + this.buffer.length);
          }
          return this.buffer.toString('hex', begin, end);
        }),
        (ByteBuffer.fromHex = function (str, littleEndian, noAssert) {
          if (!noAssert) {
            if (typeof str != 'string') throw TypeError('Illegal str: Not a string');
            if (str.length % 2 !== 0) throw TypeError('Illegal str: Length not a multiple of 2');
          }
          var bb2 = new ByteBuffer(0, littleEndian, !0);
          return ((bb2.buffer = Buffer2.from(str, 'hex')), (bb2.limit = bb2.buffer.length), bb2);
        }));
      var utfx = (function () {
        'use strict';
        var utfx2 = {};
        return (
          (utfx2.MAX_CODEPOINT = 1114111),
          (utfx2.encodeUTF8 = function (src, dst) {
            var cp = null;
            for (
              typeof src == 'number' &&
              ((cp = src),
              (src = function () {
                return null;
              }));
              cp !== null || (cp = src()) !== null;
            )
              (cp < 128
                ? dst(cp & 127)
                : cp < 2048
                  ? (dst(((cp >> 6) & 31) | 192), dst((cp & 63) | 128))
                  : cp < 65536
                    ? (dst(((cp >> 12) & 15) | 224), dst(((cp >> 6) & 63) | 128), dst((cp & 63) | 128))
                    : (dst(((cp >> 18) & 7) | 240),
                      dst(((cp >> 12) & 63) | 128),
                      dst(((cp >> 6) & 63) | 128),
                      dst((cp & 63) | 128)),
                (cp = null));
          }),
          (utfx2.decodeUTF8 = function (src, dst) {
            for (
              var a,
                b,
                c,
                d,
                fail = function (b2) {
                  b2 = b2.slice(0, b2.indexOf(null));
                  var err = Error(b2.toString());
                  throw ((err.name = 'TruncatedError'), (err.bytes = b2), err);
                };
              (a = src()) !== null;
            )
              if ((a & 128) === 0) dst(a);
              else if ((a & 224) === 192) ((b = src()) === null && fail([a, b]), dst(((a & 31) << 6) | (b & 63)));
              else if ((a & 240) === 224)
                (((b = src()) === null || (c = src()) === null) && fail([a, b, c]),
                  dst(((a & 15) << 12) | ((b & 63) << 6) | (c & 63)));
              else if ((a & 248) === 240)
                (((b = src()) === null || (c = src()) === null || (d = src()) === null) && fail([a, b, c, d]),
                  dst(((a & 7) << 18) | ((b & 63) << 12) | ((c & 63) << 6) | (d & 63)));
              else throw RangeError('Illegal starting byte: ' + a);
          }),
          (utfx2.UTF16toUTF8 = function (src, dst) {
            for (var c1, c2 = null; (c1 = c2 !== null ? c2 : src()) !== null; ) {
              if (c1 >= 55296 && c1 <= 57343 && (c2 = src()) !== null && c2 >= 56320 && c2 <= 57343) {
                (dst((c1 - 55296) * 1024 + c2 - 56320 + 65536), (c2 = null));
                continue;
              }
              dst(c1);
            }
            c2 !== null && dst(c2);
          }),
          (utfx2.UTF8toUTF16 = function (src, dst) {
            var cp = null;
            for (
              typeof src == 'number' &&
              ((cp = src),
              (src = function () {
                return null;
              }));
              cp !== null || (cp = src()) !== null;
            )
              (cp <= 65535 ? dst(cp) : ((cp -= 65536), dst((cp >> 10) + 55296), dst((cp % 1024) + 56320)), (cp = null));
          }),
          (utfx2.encodeUTF16toUTF8 = function (src, dst) {
            utfx2.UTF16toUTF8(src, function (cp) {
              utfx2.encodeUTF8(cp, dst);
            });
          }),
          (utfx2.decodeUTF8toUTF16 = function (src, dst) {
            utfx2.decodeUTF8(src, function (cp) {
              utfx2.UTF8toUTF16(cp, dst);
            });
          }),
          (utfx2.calculateCodePoint = function (cp) {
            return cp < 128 ? 1 : cp < 2048 ? 2 : cp < 65536 ? 3 : 4;
          }),
          (utfx2.calculateUTF8 = function (src) {
            for (var cp, l = 0; (cp = src()) !== null; ) l += cp < 128 ? 1 : cp < 2048 ? 2 : cp < 65536 ? 3 : 4;
            return l;
          }),
          (utfx2.calculateUTF16asUTF8 = function (src) {
            var n = 0,
              l = 0;
            return (
              utfx2.UTF16toUTF8(src, function (cp) {
                (++n, (l += cp < 128 ? 1 : cp < 2048 ? 2 : cp < 65536 ? 3 : 4));
              }),
              [n, l]
            );
          }),
          utfx2
        );
      })();
      return (
        (ByteBufferPrototype.toUTF8 = function (begin, end) {
          if ((typeof begin > 'u' && (begin = this.offset), typeof end > 'u' && (end = this.limit), !this.noAssert)) {
            if (typeof begin != 'number' || begin % 1 !== 0) throw TypeError('Illegal begin: Not an integer');
            if (((begin >>>= 0), typeof end != 'number' || end % 1 !== 0))
              throw TypeError('Illegal end: Not an integer');
            if (((end >>>= 0), begin < 0 || begin > end || end > this.buffer.length))
              throw RangeError('Illegal range: 0 <= ' + begin + ' <= ' + end + ' <= ' + this.buffer.length);
          }
          return this.buffer.toString('utf8', begin, end);
        }),
        (ByteBuffer.fromUTF8 = function (str, littleEndian, noAssert) {
          if (!noAssert && typeof str != 'string') throw TypeError('Illegal str: Not a string');
          var bb2 = new ByteBuffer(0, littleEndian, noAssert);
          return ((bb2.buffer = Buffer2.from(str, 'utf8')), (bb2.limit = bb2.buffer.length), bb2);
        }),
        (ByteBuffer.memcpy = memcpy),
        ByteBuffer
      );
    })();
  },
});
var require_protobuf = __commonJS({
  'node_modules/protobufjs/dist/protobuf.js'(exports2, module2) {
    'use strict';
    (function (global2, factory) {
      typeof define == 'function' && define.amd
        ? define(['bytebuffer'], factory)
        : typeof require == 'function' && typeof module2 == 'object' && module2 && module2.exports
          ? (module2.exports = factory(require_bytebuffer_node(), !0))
          : ((global2.dcodeIO = global2.dcodeIO || {}).ProtoBuf = factory(global2.dcodeIO.ByteBuffer));
    })(exports2, function (ByteBuffer, isCommonJS) {
      'use strict';
      var ProtoBuf = {};
      return (
        (ProtoBuf.ByteBuffer = ByteBuffer),
        (ProtoBuf.Long = ByteBuffer.Long || null),
        (ProtoBuf.VERSION = '5.0.3'),
        (ProtoBuf.WIRE_TYPES = {}),
        (ProtoBuf.WIRE_TYPES.VARINT = 0),
        (ProtoBuf.WIRE_TYPES.BITS64 = 1),
        (ProtoBuf.WIRE_TYPES.LDELIM = 2),
        (ProtoBuf.WIRE_TYPES.STARTGROUP = 3),
        (ProtoBuf.WIRE_TYPES.ENDGROUP = 4),
        (ProtoBuf.WIRE_TYPES.BITS32 = 5),
        (ProtoBuf.PACKABLE_WIRE_TYPES = [
          ProtoBuf.WIRE_TYPES.VARINT,
          ProtoBuf.WIRE_TYPES.BITS64,
          ProtoBuf.WIRE_TYPES.BITS32,
        ]),
        (ProtoBuf.TYPES = {
          int32: { name: 'int32', wireType: ProtoBuf.WIRE_TYPES.VARINT, defaultValue: 0 },
          uint32: { name: 'uint32', wireType: ProtoBuf.WIRE_TYPES.VARINT, defaultValue: 0 },
          sint32: { name: 'sint32', wireType: ProtoBuf.WIRE_TYPES.VARINT, defaultValue: 0 },
          int64: {
            name: 'int64',
            wireType: ProtoBuf.WIRE_TYPES.VARINT,
            defaultValue: ProtoBuf.Long ? ProtoBuf.Long.ZERO : void 0,
          },
          uint64: {
            name: 'uint64',
            wireType: ProtoBuf.WIRE_TYPES.VARINT,
            defaultValue: ProtoBuf.Long ? ProtoBuf.Long.UZERO : void 0,
          },
          sint64: {
            name: 'sint64',
            wireType: ProtoBuf.WIRE_TYPES.VARINT,
            defaultValue: ProtoBuf.Long ? ProtoBuf.Long.ZERO : void 0,
          },
          bool: { name: 'bool', wireType: ProtoBuf.WIRE_TYPES.VARINT, defaultValue: !1 },
          double: { name: 'double', wireType: ProtoBuf.WIRE_TYPES.BITS64, defaultValue: 0 },
          string: { name: 'string', wireType: ProtoBuf.WIRE_TYPES.LDELIM, defaultValue: '' },
          bytes: { name: 'bytes', wireType: ProtoBuf.WIRE_TYPES.LDELIM, defaultValue: null },
          fixed32: { name: 'fixed32', wireType: ProtoBuf.WIRE_TYPES.BITS32, defaultValue: 0 },
          sfixed32: { name: 'sfixed32', wireType: ProtoBuf.WIRE_TYPES.BITS32, defaultValue: 0 },
          fixed64: {
            name: 'fixed64',
            wireType: ProtoBuf.WIRE_TYPES.BITS64,
            defaultValue: ProtoBuf.Long ? ProtoBuf.Long.UZERO : void 0,
          },
          sfixed64: {
            name: 'sfixed64',
            wireType: ProtoBuf.WIRE_TYPES.BITS64,
            defaultValue: ProtoBuf.Long ? ProtoBuf.Long.ZERO : void 0,
          },
          float: { name: 'float', wireType: ProtoBuf.WIRE_TYPES.BITS32, defaultValue: 0 },
          enum: { name: 'enum', wireType: ProtoBuf.WIRE_TYPES.VARINT, defaultValue: 0 },
          message: { name: 'message', wireType: ProtoBuf.WIRE_TYPES.LDELIM, defaultValue: null },
          group: { name: 'group', wireType: ProtoBuf.WIRE_TYPES.STARTGROUP, defaultValue: null },
        }),
        (ProtoBuf.MAP_KEY_TYPES = [
          ProtoBuf.TYPES.int32,
          ProtoBuf.TYPES.sint32,
          ProtoBuf.TYPES.sfixed32,
          ProtoBuf.TYPES.uint32,
          ProtoBuf.TYPES.fixed32,
          ProtoBuf.TYPES.int64,
          ProtoBuf.TYPES.sint64,
          ProtoBuf.TYPES.sfixed64,
          ProtoBuf.TYPES.uint64,
          ProtoBuf.TYPES.fixed64,
          ProtoBuf.TYPES.bool,
          ProtoBuf.TYPES.string,
          ProtoBuf.TYPES.bytes,
        ]),
        (ProtoBuf.ID_MIN = 1),
        (ProtoBuf.ID_MAX = 536870911),
        (ProtoBuf.convertFieldsToCamelCase = !1),
        (ProtoBuf.populateAccessors = !0),
        (ProtoBuf.populateDefaults = !0),
        (ProtoBuf.Util = (function () {
          'use strict';
          var Util = {};
          return (
            (Util.IS_NODE = typeof process == 'object' && process + '' == '[object process]' && !process.browser),
            (Util.XHR = function () {
              for (
                var XMLHttpFactories = [
                    function () {
                      return new XMLHttpRequest();
                    },
                    function () {
                      return new ActiveXObject('Msxml2.XMLHTTP');
                    },
                    function () {
                      return new ActiveXObject('Msxml3.XMLHTTP');
                    },
                    function () {
                      return new ActiveXObject('Microsoft.XMLHTTP');
                    },
                  ],
                  xhr = null,
                  i = 0;
                i < XMLHttpFactories.length;
                i++
              ) {
                try {
                  xhr = XMLHttpFactories[i]();
                } catch {
                  continue;
                }
                break;
              }
              if (!xhr) throw Error('XMLHttpRequest is not supported');
              return xhr;
            }),
            (Util.fetch = function (path, callback) {
              if ((callback && typeof callback != 'function' && (callback = null), Util.IS_NODE)) {
                var fs = require('fs');
                if (callback)
                  fs.readFile(path, function (err, data) {
                    callback(err ? null : '' + data);
                  });
                else
                  try {
                    return fs.readFileSync(path);
                  } catch {
                    return null;
                  }
              } else {
                var xhr = Util.XHR();
                if (
                  (xhr.open('GET', path, !!callback),
                  xhr.setRequestHeader('Accept', 'text/plain'),
                  typeof xhr.overrideMimeType == 'function' && xhr.overrideMimeType('text/plain'),
                  callback)
                ) {
                  if (
                    ((xhr.onreadystatechange = function () {
                      xhr.readyState == 4 &&
                        (xhr.status == 200 || (xhr.status == 0 && typeof xhr.responseText == 'string')
                          ? callback(xhr.responseText)
                          : callback(null));
                    }),
                    xhr.readyState == 4)
                  )
                    return;
                  xhr.send(null);
                } else
                  return (
                    xhr.send(null),
                    xhr.status == 200 || (xhr.status == 0 && typeof xhr.responseText == 'string')
                      ? xhr.responseText
                      : null
                  );
              }
            }),
            (Util.toCamelCase = function (str) {
              return str.replace(/_([a-zA-Z])/g, function ($0, $1) {
                return $1.toUpperCase();
              });
            }),
            Util
          );
        })()),
        (ProtoBuf.Lang = {
          DELIM: /[\s\{\}=;:\[\],'"\(\)<>]/g,
          RULE: /^(?:required|optional|repeated|map)$/,
          TYPE: /^(?:double|float|int32|uint32|sint32|int64|uint64|sint64|fixed32|sfixed32|fixed64|sfixed64|bool|string|bytes)$/,
          NAME: /^[a-zA-Z_][a-zA-Z_0-9]*$/,
          TYPEDEF: /^[a-zA-Z][a-zA-Z_0-9]*$/,
          TYPEREF: /^(?:\.?[a-zA-Z_][a-zA-Z_0-9]*)(?:\.[a-zA-Z_][a-zA-Z_0-9]*)*$/,
          FQTYPEREF: /^(?:\.[a-zA-Z_][a-zA-Z_0-9]*)+$/,
          NUMBER: /^-?(?:[1-9][0-9]*|0|0[xX][0-9a-fA-F]+|0[0-7]+|([0-9]*(\.[0-9]*)?([Ee][+-]?[0-9]+)?)|inf|nan)$/,
          NUMBER_DEC: /^(?:[1-9][0-9]*|0)$/,
          NUMBER_HEX: /^0[xX][0-9a-fA-F]+$/,
          NUMBER_OCT: /^0[0-7]+$/,
          NUMBER_FLT: /^([0-9]*(\.[0-9]*)?([Ee][+-]?[0-9]+)?|inf|nan)$/,
          BOOL: /^(?:true|false)$/i,
          ID: /^(?:[1-9][0-9]*|0|0[xX][0-9a-fA-F]+|0[0-7]+)$/,
          NEGID: /^\-?(?:[1-9][0-9]*|0|0[xX][0-9a-fA-F]+|0[0-7]+)$/,
          WHITESPACE: /\s/,
          STRING: /(?:"([^"\\]*(?:\\.[^"\\]*)*)")|(?:'([^'\\]*(?:\\.[^'\\]*)*)')/g,
          STRING_DQ: /(?:"([^"\\]*(?:\\.[^"\\]*)*)")/g,
          STRING_SQ: /(?:'([^'\\]*(?:\\.[^'\\]*)*)')/g,
        }),
        (ProtoBuf.DotProto = (function (ProtoBuf2, Lang) {
          'use strict';
          var DotProto = {},
            Tokenizer = function (proto) {
              ((this.source = proto + ''),
                (this.index = 0),
                (this.line = 1),
                (this.stack = []),
                (this._stringOpen = null));
            },
            TokenizerPrototype = Tokenizer.prototype;
          ((TokenizerPrototype._readString = function () {
            var re = this._stringOpen === '"' ? Lang.STRING_DQ : Lang.STRING_SQ;
            re.lastIndex = this.index - 1;
            var match = re.exec(this.source);
            if (!match) throw Error('unterminated string');
            return (
              (this.index = re.lastIndex),
              this.stack.push(this._stringOpen),
              (this._stringOpen = null),
              match[1]
            );
          }),
            (TokenizerPrototype.next = function () {
              if (this.stack.length > 0) return this.stack.shift();
              if (this.index >= this.source.length) return null;
              if (this._stringOpen !== null) return this._readString();
              var repeat, prev, next;
              do {
                for (repeat = !1; Lang.WHITESPACE.test((next = this.source.charAt(this.index))); )
                  if (
                    (next ===
                      `
` && ++this.line,
                    ++this.index === this.source.length)
                  )
                    return null;
                if (this.source.charAt(this.index) === '/')
                  if ((++this.index, this.source.charAt(this.index) === '/')) {
                    for (
                      ;
                      this.source.charAt(++this.index) !==
                      `
`;
                    )
                      if (this.index == this.source.length) return null;
                    (++this.index, ++this.line, (repeat = !0));
                  } else if ((next = this.source.charAt(this.index)) === '*') {
                    do {
                      if (
                        (next ===
                          `
` && ++this.line,
                        ++this.index === this.source.length)
                      )
                        return null;
                      ((prev = next), (next = this.source.charAt(this.index)));
                    } while (prev !== '*' || next !== '/');
                    (++this.index, (repeat = !0));
                  } else return '/';
              } while (repeat);
              if (this.index === this.source.length) return null;
              var end = this.index;
              Lang.DELIM.lastIndex = 0;
              var delim = Lang.DELIM.test(this.source.charAt(end++));
              if (!delim) for (; end < this.source.length && !Lang.DELIM.test(this.source.charAt(end)); ) ++end;
              var token = this.source.substring(this.index, (this.index = end));
              return ((token === '"' || token === "'") && (this._stringOpen = token), token);
            }),
            (TokenizerPrototype.peek = function () {
              if (this.stack.length === 0) {
                var token = this.next();
                if (token === null) return null;
                this.stack.push(token);
              }
              return this.stack[0];
            }),
            (TokenizerPrototype.skip = function (expected) {
              var actual = this.next();
              if (actual !== expected) throw Error("illegal '" + actual + "', '" + expected + "' expected");
            }),
            (TokenizerPrototype.omit = function (expected) {
              return this.peek() === expected ? (this.next(), !0) : !1;
            }),
            (TokenizerPrototype.toString = function () {
              return 'Tokenizer (' + this.index + '/' + this.source.length + ' at line ' + this.line + ')';
            }),
            (DotProto.Tokenizer = Tokenizer));
          var Parser = function (source) {
              ((this.tn = new Tokenizer(source)), (this.proto3 = !1));
            },
            ParserPrototype = Parser.prototype;
          ((ParserPrototype.parse = function () {
            var topLevel = {
                name: '[ROOT]',
                package: null,
                messages: [],
                enums: [],
                imports: [],
                options: {},
                services: [],
              },
              token,
              head = !0,
              weak;
            try {
              for (; (token = this.tn.next()); )
                switch (token) {
                  case 'package':
                    if (!head || topLevel.package !== null) throw Error("unexpected 'package'");
                    if (((token = this.tn.next()), !Lang.TYPEREF.test(token)))
                      throw Error('illegal package name: ' + token);
                    (this.tn.skip(';'), (topLevel.package = token));
                    break;
                  case 'import':
                    if (!head) throw Error("unexpected 'import'");
                    ((token = this.tn.peek()),
                      (token === 'public' || (weak = token === 'weak')) && this.tn.next(),
                      (token = this._readString()),
                      this.tn.skip(';'),
                      weak || topLevel.imports.push(token));
                    break;
                  case 'syntax':
                    if (!head) throw Error("unexpected 'syntax'");
                    (this.tn.skip('='),
                      (topLevel.syntax = this._readString()) === 'proto3' && (this.proto3 = !0),
                      this.tn.skip(';'));
                    break;
                  case 'message':
                    (this._parseMessage(topLevel, null), (head = !1));
                    break;
                  case 'enum':
                    (this._parseEnum(topLevel), (head = !1));
                    break;
                  case 'option':
                    this._parseOption(topLevel);
                    break;
                  case 'service':
                    this._parseService(topLevel);
                    break;
                  case 'extend':
                    this._parseExtend(topLevel);
                    break;
                  default:
                    throw Error("unexpected '" + token + "'");
                }
            } catch (e) {
              throw ((e.message = 'Parse error at line ' + this.tn.line + ': ' + e.message), e);
            }
            return (delete topLevel.name, topLevel);
          }),
            (Parser.parse = function (source) {
              return new Parser(source).parse();
            }));
          function mkId(value, mayBeNegative) {
            var id = -1,
              sign = 1;
            if ((value.charAt(0) == '-' && ((sign = -1), (value = value.substring(1))), Lang.NUMBER_DEC.test(value)))
              id = parseInt(value);
            else if (Lang.NUMBER_HEX.test(value)) id = parseInt(value.substring(2), 16);
            else if (Lang.NUMBER_OCT.test(value)) id = parseInt(value.substring(1), 8);
            else throw Error('illegal id value: ' + (sign < 0 ? '-' : '') + value);
            if (((id = (sign * id) | 0), !mayBeNegative && id < 0))
              throw Error('illegal id value: ' + (sign < 0 ? '-' : '') + value);
            return id;
          }
          function mkNumber(val) {
            var sign = 1;
            if ((val.charAt(0) == '-' && ((sign = -1), (val = val.substring(1))), Lang.NUMBER_DEC.test(val)))
              return sign * parseInt(val, 10);
            if (Lang.NUMBER_HEX.test(val)) return sign * parseInt(val.substring(2), 16);
            if (Lang.NUMBER_OCT.test(val)) return sign * parseInt(val.substring(1), 8);
            if (val === 'inf') return sign * (1 / 0);
            if (val === 'nan') return NaN;
            if (Lang.NUMBER_FLT.test(val)) return sign * parseFloat(val);
            throw Error('illegal number value: ' + (sign < 0 ? '-' : '') + val);
          }
          ((ParserPrototype._readString = function () {
            var value = '',
              token,
              delim;
            do {
              if (((delim = this.tn.next()), delim !== "'" && delim !== '"'))
                throw Error('illegal string delimiter: ' + delim);
              ((value += this.tn.next()), this.tn.skip(delim), (token = this.tn.peek()));
            } while (token === '"' || token === '"');
            return value;
          }),
            (ParserPrototype._readValue = function (mayBeTypeRef) {
              var token = this.tn.peek(),
                value;
              if (token === '"' || token === "'") return this._readString();
              if ((this.tn.next(), Lang.NUMBER.test(token))) return mkNumber(token);
              if (Lang.BOOL.test(token)) return token.toLowerCase() === 'true';
              if (mayBeTypeRef && Lang.TYPEREF.test(token)) return token;
              throw Error('illegal value: ' + token);
            }),
            (ParserPrototype._parseOption = function (parent, isList) {
              var token = this.tn.next(),
                custom = !1;
              if ((token === '(' && ((custom = !0), (token = this.tn.next())), !Lang.TYPEREF.test(token)))
                throw Error('illegal option name: ' + token);
              var name = token;
              (custom &&
                (this.tn.skip(')'),
                (name = '(' + name + ')'),
                (token = this.tn.peek()),
                Lang.FQTYPEREF.test(token) && ((name += token), this.tn.next())),
                this.tn.skip('='),
                this._parseOptionValue(parent, name),
                isList || this.tn.skip(';'));
            }));
          function setOption(options, name, value) {
            typeof options[name] > 'u'
              ? (options[name] = value)
              : (Array.isArray(options[name]) || (options[name] = [options[name]]), options[name].push(value));
          }
          return (
            (ParserPrototype._parseOptionValue = function (parent, name) {
              var token = this.tn.peek();
              if (token !== '{') setOption(parent.options, name, this._readValue(!0));
              else
                for (this.tn.skip('{'); (token = this.tn.next()) !== '}'; ) {
                  if (!Lang.NAME.test(token)) throw Error('illegal option name: ' + name + '.' + token);
                  this.tn.omit(':')
                    ? setOption(parent.options, name + '.' + token, this._readValue(!0))
                    : this._parseOptionValue(parent, name + '.' + token);
                }
            }),
            (ParserPrototype._parseService = function (parent) {
              var token = this.tn.next();
              if (!Lang.NAME.test(token)) throw Error('illegal service name at line ' + this.tn.line + ': ' + token);
              var name = token,
                svc = { name, rpc: {}, options: {} };
              for (this.tn.skip('{'); (token = this.tn.next()) !== '}'; )
                if (token === 'option') this._parseOption(svc);
                else if (token === 'rpc') this._parseServiceRPC(svc);
                else throw Error('illegal service token: ' + token);
              (this.tn.omit(';'), parent.services.push(svc));
            }),
            (ParserPrototype._parseServiceRPC = function (svc) {
              var type = 'rpc',
                token = this.tn.next();
              if (!Lang.NAME.test(token)) throw Error('illegal rpc service method name: ' + token);
              var name = token,
                method = { request: null, response: null, request_stream: !1, response_stream: !1, options: {} };
              if (
                (this.tn.skip('('),
                (token = this.tn.next()),
                token.toLowerCase() === 'stream' && ((method.request_stream = !0), (token = this.tn.next())),
                !Lang.TYPEREF.test(token))
              )
                throw Error('illegal rpc service request type: ' + token);
              if (
                ((method.request = token),
                this.tn.skip(')'),
                (token = this.tn.next()),
                token.toLowerCase() !== 'returns')
              )
                throw Error('illegal rpc service request type delimiter: ' + token);
              if (
                (this.tn.skip('('),
                (token = this.tn.next()),
                token.toLowerCase() === 'stream' && ((method.response_stream = !0), (token = this.tn.next())),
                (method.response = token),
                this.tn.skip(')'),
                (token = this.tn.peek()),
                token === '{')
              ) {
                for (this.tn.next(); (token = this.tn.next()) !== '}'; )
                  if (token === 'option') this._parseOption(method);
                  else throw Error('illegal rpc service token: ' + token);
                this.tn.omit(';');
              } else this.tn.skip(';');
              (typeof svc[type] > 'u' && (svc[type] = {}), (svc[type][name] = method));
            }),
            (ParserPrototype._parseMessage = function (parent, fld) {
              var isGroup = !!fld,
                token = this.tn.next(),
                msg = { name: '', fields: [], enums: [], messages: [], options: {}, services: [], oneofs: {} };
              if (!Lang.NAME.test(token)) throw Error('illegal ' + (isGroup ? 'group' : 'message') + ' name: ' + token);
              for (
                msg.name = token,
                  isGroup && (this.tn.skip('='), (fld.id = mkId(this.tn.next())), (msg.isGroup = !0)),
                  token = this.tn.peek(),
                  token === '[' && fld && this._parseFieldOptions(fld),
                  this.tn.skip('{');
                (token = this.tn.next()) !== '}';
              )
                if (Lang.RULE.test(token)) this._parseMessageField(msg, token);
                else if (token === 'oneof') this._parseMessageOneOf(msg);
                else if (token === 'enum') this._parseEnum(msg);
                else if (token === 'message') this._parseMessage(msg);
                else if (token === 'option') this._parseOption(msg);
                else if (token === 'service') this._parseService(msg);
                else if (token === 'extensions')
                  msg.hasOwnProperty('extensions')
                    ? (msg.extensions = msg.extensions.concat(this._parseExtensionRanges()))
                    : (msg.extensions = this._parseExtensionRanges());
                else if (token === 'reserved') this._parseIgnored();
                else if (token === 'extend') this._parseExtend(msg);
                else if (Lang.TYPEREF.test(token)) {
                  if (!this.proto3) throw Error('illegal field rule: ' + token);
                  this._parseMessageField(msg, 'optional', token);
                } else throw Error('illegal message token: ' + token);
              return (this.tn.omit(';'), parent.messages.push(msg), msg);
            }),
            (ParserPrototype._parseIgnored = function () {
              for (; this.tn.peek() !== ';'; ) this.tn.next();
              this.tn.skip(';');
            }),
            (ParserPrototype._parseMessageField = function (msg, rule, type) {
              if (!Lang.RULE.test(rule)) throw Error('illegal message field rule: ' + rule);
              var fld = { rule, type: '', name: '', options: {}, id: 0 },
                token;
              if (rule === 'map') {
                if (type) throw Error('illegal type: ' + type);
                if ((this.tn.skip('<'), (token = this.tn.next()), !Lang.TYPE.test(token) && !Lang.TYPEREF.test(token)))
                  throw Error('illegal message field type: ' + token);
                if (
                  ((fld.keytype = token),
                  this.tn.skip(','),
                  (token = this.tn.next()),
                  !Lang.TYPE.test(token) && !Lang.TYPEREF.test(token))
                )
                  throw Error('illegal message field: ' + token);
                if (((fld.type = token), this.tn.skip('>'), (token = this.tn.next()), !Lang.NAME.test(token)))
                  throw Error('illegal message field name: ' + token);
                ((fld.name = token),
                  this.tn.skip('='),
                  (fld.id = mkId(this.tn.next())),
                  (token = this.tn.peek()),
                  token === '[' && this._parseFieldOptions(fld),
                  this.tn.skip(';'));
              } else if (((type = typeof type < 'u' ? type : this.tn.next()), type === 'group')) {
                var grp = this._parseMessage(msg, fld);
                if (!/^[A-Z]/.test(grp.name)) throw Error('illegal group name: ' + grp.name);
                ((fld.type = grp.name), (fld.name = grp.name.toLowerCase()), this.tn.omit(';'));
              } else {
                if (!Lang.TYPE.test(type) && !Lang.TYPEREF.test(type))
                  throw Error('illegal message field type: ' + type);
                if (((fld.type = type), (token = this.tn.next()), !Lang.NAME.test(token)))
                  throw Error('illegal message field name: ' + token);
                ((fld.name = token),
                  this.tn.skip('='),
                  (fld.id = mkId(this.tn.next())),
                  (token = this.tn.peek()),
                  token === '[' && this._parseFieldOptions(fld),
                  this.tn.skip(';'));
              }
              return (msg.fields.push(fld), fld);
            }),
            (ParserPrototype._parseMessageOneOf = function (msg) {
              var token = this.tn.next();
              if (!Lang.NAME.test(token)) throw Error('illegal oneof name: ' + token);
              var name = token,
                fld,
                fields = [];
              for (this.tn.skip('{'); (token = this.tn.next()) !== '}'; )
                ((fld = this._parseMessageField(msg, 'optional', token)), (fld.oneof = name), fields.push(fld.id));
              (this.tn.omit(';'), (msg.oneofs[name] = fields));
            }),
            (ParserPrototype._parseFieldOptions = function (fld) {
              this.tn.skip('[');
              for (var token, first = !0; (token = this.tn.peek()) !== ']'; )
                (first || this.tn.skip(','), this._parseOption(fld, !0), (first = !1));
              this.tn.next();
            }),
            (ParserPrototype._parseEnum = function (msg) {
              var enm = { name: '', values: [], options: {} },
                token = this.tn.next();
              if (!Lang.NAME.test(token)) throw Error('illegal name: ' + token);
              for (enm.name = token, this.tn.skip('{'); (token = this.tn.next()) !== '}'; )
                if (token === 'option') this._parseOption(enm);
                else {
                  if (!Lang.NAME.test(token)) throw Error('illegal name: ' + token);
                  this.tn.skip('=');
                  var val = { name: token, id: mkId(this.tn.next(), !0) };
                  ((token = this.tn.peek()),
                    token === '[' && this._parseFieldOptions({ options: {} }),
                    this.tn.skip(';'),
                    enm.values.push(val));
                }
              (this.tn.omit(';'), msg.enums.push(enm));
            }),
            (ParserPrototype._parseExtensionRanges = function () {
              var ranges = [],
                token,
                range,
                value;
              do {
                for (range = []; ; ) {
                  switch (((token = this.tn.next()), token)) {
                    case 'min':
                      value = ProtoBuf2.ID_MIN;
                      break;
                    case 'max':
                      value = ProtoBuf2.ID_MAX;
                      break;
                    default:
                      value = mkNumber(token);
                      break;
                  }
                  if ((range.push(value), range.length === 2)) break;
                  if (this.tn.peek() !== 'to') {
                    range.push(value);
                    break;
                  }
                  this.tn.next();
                }
                ranges.push(range);
              } while (this.tn.omit(','));
              return (this.tn.skip(';'), ranges);
            }),
            (ParserPrototype._parseExtend = function (parent) {
              var token = this.tn.next();
              if (!Lang.TYPEREF.test(token)) throw Error('illegal extend reference: ' + token);
              var ext = { ref: token, fields: [] };
              for (this.tn.skip('{'); (token = this.tn.next()) !== '}'; )
                if (Lang.RULE.test(token)) this._parseMessageField(ext, token);
                else if (Lang.TYPEREF.test(token)) {
                  if (!this.proto3) throw Error('illegal field rule: ' + token);
                  this._parseMessageField(ext, 'optional', token);
                } else throw Error('illegal extend token: ' + token);
              return (this.tn.omit(';'), parent.messages.push(ext), ext);
            }),
            (ParserPrototype.toString = function () {
              return 'Parser at line ' + this.tn.line;
            }),
            (DotProto.Parser = Parser),
            DotProto
          );
        })(ProtoBuf, ProtoBuf.Lang)),
        (ProtoBuf.Reflect = (function (ProtoBuf2) {
          'use strict';
          var Reflect2 = {},
            T = function (builder, parent, name) {
              ((this.builder = builder), (this.parent = parent), (this.name = name), this.className);
            },
            TPrototype = T.prototype;
          ((TPrototype.fqn = function () {
            var name = this.name,
              ptr = this;
            do {
              if (((ptr = ptr.parent), ptr == null)) break;
              name = ptr.name + '.' + name;
            } while (!0);
            return name;
          }),
            (TPrototype.toString = function (includeClass) {
              return (includeClass ? this.className + ' ' : '') + this.fqn();
            }),
            (TPrototype.build = function () {
              throw Error(this.toString(!0) + ' cannot be built directly');
            }),
            (Reflect2.T = T));
          var Namespace = function (builder, parent, name, options, syntax) {
              (T.call(this, builder, parent, name),
                (this.className = 'Namespace'),
                (this.children = []),
                (this.options = options || {}),
                (this.syntax = syntax || 'proto2'));
            },
            NamespacePrototype = (Namespace.prototype = Object.create(T.prototype));
          ((NamespacePrototype.getChildren = function (type) {
            if (((type = type || null), type == null)) return this.children.slice();
            for (var children = [], i = 0, k = this.children.length; i < k; ++i)
              this.children[i] instanceof type && children.push(this.children[i]);
            return children;
          }),
            (NamespacePrototype.addChild = function (child) {
              var other;
              if ((other = this.getChild(child.name)))
                if (
                  other instanceof Message.Field &&
                  other.name !== other.originalName &&
                  this.getChild(other.originalName) === null
                )
                  other.name = other.originalName;
                else if (
                  child instanceof Message.Field &&
                  child.name !== child.originalName &&
                  this.getChild(child.originalName) === null
                )
                  child.name = child.originalName;
                else throw Error('Duplicate name in namespace ' + this.toString(!0) + ': ' + child.name);
              this.children.push(child);
            }),
            (NamespacePrototype.getChild = function (nameOrId) {
              for (var key = typeof nameOrId == 'number' ? 'id' : 'name', i = 0, k = this.children.length; i < k; ++i)
                if (this.children[i][key] === nameOrId) return this.children[i];
              return null;
            }),
            (NamespacePrototype.resolve = function (qn, excludeNonNamespace) {
              var part = typeof qn == 'string' ? qn.split('.') : qn,
                ptr = this,
                i = 0;
              if (part[i] === '') {
                for (; ptr.parent !== null; ) ptr = ptr.parent;
                i++;
              }
              var child;
              do {
                do {
                  if (!(ptr instanceof Reflect2.Namespace)) {
                    ptr = null;
                    break;
                  }
                  if (
                    ((child = ptr.getChild(part[i])),
                    !child ||
                      !(child instanceof Reflect2.T) ||
                      (excludeNonNamespace && !(child instanceof Reflect2.Namespace)))
                  ) {
                    ptr = null;
                    break;
                  }
                  ((ptr = child), i++);
                } while (i < part.length);
                if (ptr != null) break;
                if (this.parent !== null) return this.parent.resolve(qn, excludeNonNamespace);
              } while (ptr != null);
              return ptr;
            }),
            (NamespacePrototype.qn = function (t) {
              var part = [],
                ptr = t;
              do (part.unshift(ptr.name), (ptr = ptr.parent));
              while (ptr !== null);
              for (var len = 1; len <= part.length; len++) {
                var qn = part.slice(part.length - len);
                if (t === this.resolve(qn, t instanceof Reflect2.Namespace)) return qn.join('.');
              }
              return t.fqn();
            }),
            (NamespacePrototype.build = function () {
              for (var ns = {}, children = this.children, i = 0, k = children.length, child; i < k; ++i)
                ((child = children[i]), child instanceof Namespace && (ns[child.name] = child.build()));
              return (Object.defineProperty && Object.defineProperty(ns, '$options', { value: this.buildOpt() }), ns);
            }),
            (NamespacePrototype.buildOpt = function () {
              for (var opt = {}, keys = Object.keys(this.options), i = 0, k = keys.length; i < k; ++i) {
                var key = keys[i],
                  val = this.options[keys[i]];
                opt[key] = val;
              }
              return opt;
            }),
            (NamespacePrototype.getOption = function (name) {
              return typeof name > 'u' ? this.options : typeof this.options[name] < 'u' ? this.options[name] : null;
            }),
            (Reflect2.Namespace = Namespace));
          var Element = function (type, resolvedType, isMapKey, syntax, name) {
              if (
                ((this.type = type),
                (this.resolvedType = resolvedType),
                (this.isMapKey = isMapKey),
                (this.syntax = syntax),
                (this.name = name),
                isMapKey && ProtoBuf2.MAP_KEY_TYPES.indexOf(type) < 0)
              )
                throw Error('Invalid map key type: ' + type.name);
            },
            ElementPrototype = Element.prototype;
          function mkDefault(type) {
            if ((typeof type == 'string' && (type = ProtoBuf2.TYPES[type]), typeof type.defaultValue > 'u'))
              throw Error('default value for type ' + type.name + ' is not supported');
            return type == ProtoBuf2.TYPES.bytes ? new ByteBuffer(0) : type.defaultValue;
          }
          Element.defaultFieldValue = mkDefault;
          function mkLong(value, unsigned) {
            if (
              value &&
              typeof value.low == 'number' &&
              typeof value.high == 'number' &&
              typeof value.unsigned == 'boolean' &&
              value.low === value.low &&
              value.high === value.high
            )
              return new ProtoBuf2.Long(value.low, value.high, typeof unsigned > 'u' ? value.unsigned : unsigned);
            if (typeof value == 'string') return ProtoBuf2.Long.fromString(value, unsigned || !1, 10);
            if (typeof value == 'number') return ProtoBuf2.Long.fromNumber(value, unsigned || !1);
            throw Error('not convertible to Long');
          }
          ((ElementPrototype.toString = function () {
            return (this.name || '') + (this.isMapKey ? 'map' : 'value') + ' element';
          }),
            (ElementPrototype.verifyValue = function (value) {
              var self2 = this;
              function fail(val, msg) {
                throw Error(
                  'Illegal value for ' +
                    self2.toString(!0) +
                    ' of type ' +
                    self2.type.name +
                    ': ' +
                    val +
                    ' (' +
                    msg +
                    ')'
                );
              }
              switch (this.type) {
                case ProtoBuf2.TYPES.int32:
                case ProtoBuf2.TYPES.sint32:
                case ProtoBuf2.TYPES.sfixed32:
                  return (
                    (typeof value != 'number' || (value === value && value % 1 !== 0)) &&
                      fail(typeof value, 'not an integer'),
                    value > 4294967295 ? value | 0 : value
                  );
                case ProtoBuf2.TYPES.uint32:
                case ProtoBuf2.TYPES.fixed32:
                  return (
                    (typeof value != 'number' || (value === value && value % 1 !== 0)) &&
                      fail(typeof value, 'not an integer'),
                    value < 0 ? value >>> 0 : value
                  );
                case ProtoBuf2.TYPES.int64:
                case ProtoBuf2.TYPES.sint64:
                case ProtoBuf2.TYPES.sfixed64:
                  if (ProtoBuf2.Long)
                    try {
                      return mkLong(value, !1);
                    } catch (e) {
                      fail(typeof value, e.message);
                    }
                  else fail(typeof value, 'requires Long.js');
                case ProtoBuf2.TYPES.uint64:
                case ProtoBuf2.TYPES.fixed64:
                  if (ProtoBuf2.Long)
                    try {
                      return mkLong(value, !0);
                    } catch (e) {
                      fail(typeof value, e.message);
                    }
                  else fail(typeof value, 'requires Long.js');
                case ProtoBuf2.TYPES.bool:
                  return (typeof value != 'boolean' && fail(typeof value, 'not a boolean'), value);
                case ProtoBuf2.TYPES.float:
                case ProtoBuf2.TYPES.double:
                  return (typeof value != 'number' && fail(typeof value, 'not a number'), value);
                case ProtoBuf2.TYPES.string:
                  return (
                    typeof value != 'string' &&
                      !(value && value instanceof String) &&
                      fail(typeof value, 'not a string'),
                    '' + value
                  );
                case ProtoBuf2.TYPES.bytes:
                  return ByteBuffer.isByteBuffer(value) ? value : ByteBuffer.wrap(value, 'base64');
                case ProtoBuf2.TYPES.enum: {
                  var values = this.resolvedType.getChildren(ProtoBuf2.Reflect.Enum.Value);
                  for (i = 0; i < values.length; i++) {
                    if (values[i].name == value) return values[i].id;
                    if (values[i].id == value) return values[i].id;
                  }
                  if (this.syntax === 'proto3')
                    return (
                      (typeof value != 'number' || (value === value && value % 1 !== 0)) &&
                        fail(typeof value, 'not an integer'),
                      (value > 4294967295 || value < 0) && fail(typeof value, 'not in range for uint32'),
                      value
                    );
                  fail(value, 'not a valid enum value');
                }
                case ProtoBuf2.TYPES.group:
                case ProtoBuf2.TYPES.message: {
                  if (
                    ((!value || typeof value != 'object') && fail(typeof value, 'object expected'),
                    value instanceof this.resolvedType.clazz)
                  )
                    return value;
                  if (value instanceof ProtoBuf2.Builder.Message) {
                    var obj = {};
                    for (var i in value) value.hasOwnProperty(i) && (obj[i] = value[i]);
                    value = obj;
                  }
                  return new this.resolvedType.clazz(value);
                }
              }
              throw Error(
                '[INTERNAL] Illegal value for ' +
                  this.toString(!0) +
                  ': ' +
                  value +
                  ' (undefined type ' +
                  this.type +
                  ')'
              );
            }),
            (ElementPrototype.calculateLength = function (id, value) {
              if (value === null) return 0;
              var n;
              switch (this.type) {
                case ProtoBuf2.TYPES.int32:
                  return value < 0 ? ByteBuffer.calculateVarint64(value) : ByteBuffer.calculateVarint32(value);
                case ProtoBuf2.TYPES.uint32:
                  return ByteBuffer.calculateVarint32(value);
                case ProtoBuf2.TYPES.sint32:
                  return ByteBuffer.calculateVarint32(ByteBuffer.zigZagEncode32(value));
                case ProtoBuf2.TYPES.fixed32:
                case ProtoBuf2.TYPES.sfixed32:
                case ProtoBuf2.TYPES.float:
                  return 4;
                case ProtoBuf2.TYPES.int64:
                case ProtoBuf2.TYPES.uint64:
                  return ByteBuffer.calculateVarint64(value);
                case ProtoBuf2.TYPES.sint64:
                  return ByteBuffer.calculateVarint64(ByteBuffer.zigZagEncode64(value));
                case ProtoBuf2.TYPES.fixed64:
                case ProtoBuf2.TYPES.sfixed64:
                  return 8;
                case ProtoBuf2.TYPES.bool:
                  return 1;
                case ProtoBuf2.TYPES.enum:
                  return ByteBuffer.calculateVarint32(value);
                case ProtoBuf2.TYPES.double:
                  return 8;
                case ProtoBuf2.TYPES.string:
                  return ((n = ByteBuffer.calculateUTF8Bytes(value)), ByteBuffer.calculateVarint32(n) + n);
                case ProtoBuf2.TYPES.bytes:
                  if (value.remaining() < 0)
                    throw Error(
                      'Illegal value for ' + this.toString(!0) + ': ' + value.remaining() + ' bytes remaining'
                    );
                  return ByteBuffer.calculateVarint32(value.remaining()) + value.remaining();
                case ProtoBuf2.TYPES.message:
                  return ((n = this.resolvedType.calculate(value)), ByteBuffer.calculateVarint32(n) + n);
                case ProtoBuf2.TYPES.group:
                  return (
                    (n = this.resolvedType.calculate(value)),
                    n + ByteBuffer.calculateVarint32((id << 3) | ProtoBuf2.WIRE_TYPES.ENDGROUP)
                  );
              }
              throw Error(
                '[INTERNAL] Illegal value to encode in ' + this.toString(!0) + ': ' + value + ' (unknown type)'
              );
            }),
            (ElementPrototype.encodeValue = function (id, value, buffer) {
              if (value === null) return buffer;
              switch (this.type) {
                case ProtoBuf2.TYPES.int32:
                  value < 0 ? buffer.writeVarint64(value) : buffer.writeVarint32(value);
                  break;
                case ProtoBuf2.TYPES.uint32:
                  buffer.writeVarint32(value);
                  break;
                case ProtoBuf2.TYPES.sint32:
                  buffer.writeVarint32ZigZag(value);
                  break;
                case ProtoBuf2.TYPES.fixed32:
                  buffer.writeUint32(value);
                  break;
                case ProtoBuf2.TYPES.sfixed32:
                  buffer.writeInt32(value);
                  break;
                case ProtoBuf2.TYPES.int64:
                case ProtoBuf2.TYPES.uint64:
                  buffer.writeVarint64(value);
                  break;
                case ProtoBuf2.TYPES.sint64:
                  buffer.writeVarint64ZigZag(value);
                  break;
                case ProtoBuf2.TYPES.fixed64:
                  buffer.writeUint64(value);
                  break;
                case ProtoBuf2.TYPES.sfixed64:
                  buffer.writeInt64(value);
                  break;
                case ProtoBuf2.TYPES.bool:
                  typeof value == 'string'
                    ? buffer.writeVarint32(value.toLowerCase() === 'false' ? 0 : !!value)
                    : buffer.writeVarint32(value ? 1 : 0);
                  break;
                case ProtoBuf2.TYPES.enum:
                  buffer.writeVarint32(value);
                  break;
                case ProtoBuf2.TYPES.float:
                  buffer.writeFloat32(value);
                  break;
                case ProtoBuf2.TYPES.double:
                  buffer.writeFloat64(value);
                  break;
                case ProtoBuf2.TYPES.string:
                  buffer.writeVString(value);
                  break;
                case ProtoBuf2.TYPES.bytes:
                  if (value.remaining() < 0)
                    throw Error(
                      'Illegal value for ' + this.toString(!0) + ': ' + value.remaining() + ' bytes remaining'
                    );
                  var prevOffset = value.offset;
                  (buffer.writeVarint32(value.remaining()), buffer.append(value), (value.offset = prevOffset));
                  break;
                case ProtoBuf2.TYPES.message:
                  var bb2 = new ByteBuffer().LE();
                  (this.resolvedType.encode(value, bb2), buffer.writeVarint32(bb2.offset), buffer.append(bb2.flip()));
                  break;
                case ProtoBuf2.TYPES.group:
                  (this.resolvedType.encode(value, buffer),
                    buffer.writeVarint32((id << 3) | ProtoBuf2.WIRE_TYPES.ENDGROUP));
                  break;
                default:
                  throw Error(
                    '[INTERNAL] Illegal value to encode in ' + this.toString(!0) + ': ' + value + ' (unknown type)'
                  );
              }
              return buffer;
            }),
            (ElementPrototype.decode = function (buffer, wireType, id) {
              if (wireType != this.type.wireType) throw Error('Unexpected wire type for element');
              var value, nBytes;
              switch (this.type) {
                case ProtoBuf2.TYPES.int32:
                  return buffer.readVarint32() | 0;
                case ProtoBuf2.TYPES.uint32:
                  return buffer.readVarint32() >>> 0;
                case ProtoBuf2.TYPES.sint32:
                  return buffer.readVarint32ZigZag() | 0;
                case ProtoBuf2.TYPES.fixed32:
                  return buffer.readUint32() >>> 0;
                case ProtoBuf2.TYPES.sfixed32:
                  return buffer.readInt32() | 0;
                case ProtoBuf2.TYPES.int64:
                  return buffer.readVarint64();
                case ProtoBuf2.TYPES.uint64:
                  return buffer.readVarint64().toUnsigned();
                case ProtoBuf2.TYPES.sint64:
                  return buffer.readVarint64ZigZag();
                case ProtoBuf2.TYPES.fixed64:
                  return buffer.readUint64();
                case ProtoBuf2.TYPES.sfixed64:
                  return buffer.readInt64();
                case ProtoBuf2.TYPES.bool:
                  return !!buffer.readVarint32();
                case ProtoBuf2.TYPES.enum:
                  return buffer.readVarint32();
                case ProtoBuf2.TYPES.float:
                  return buffer.readFloat();
                case ProtoBuf2.TYPES.double:
                  return buffer.readDouble();
                case ProtoBuf2.TYPES.string:
                  return buffer.readVString();
                case ProtoBuf2.TYPES.bytes: {
                  if (((nBytes = buffer.readVarint32()), buffer.remaining() < nBytes))
                    throw Error(
                      'Illegal number of bytes for ' +
                        this.toString(!0) +
                        ': ' +
                        nBytes +
                        ' required but got only ' +
                        buffer.remaining()
                    );
                  return (
                    (value = buffer.clone()),
                    (value.limit = value.offset + nBytes),
                    (buffer.offset += nBytes),
                    value
                  );
                }
                case ProtoBuf2.TYPES.message:
                  return ((nBytes = buffer.readVarint32()), this.resolvedType.decode(buffer, nBytes));
                case ProtoBuf2.TYPES.group:
                  return this.resolvedType.decode(buffer, -1, id);
              }
              throw Error('[INTERNAL] Illegal decode type');
            }),
            (ElementPrototype.valueFromString = function (str) {
              if (!this.isMapKey) throw Error('valueFromString() called on non-map-key element');
              switch (this.type) {
                case ProtoBuf2.TYPES.int32:
                case ProtoBuf2.TYPES.sint32:
                case ProtoBuf2.TYPES.sfixed32:
                case ProtoBuf2.TYPES.uint32:
                case ProtoBuf2.TYPES.fixed32:
                  return this.verifyValue(parseInt(str));
                case ProtoBuf2.TYPES.int64:
                case ProtoBuf2.TYPES.sint64:
                case ProtoBuf2.TYPES.sfixed64:
                case ProtoBuf2.TYPES.uint64:
                case ProtoBuf2.TYPES.fixed64:
                  return this.verifyValue(str);
                case ProtoBuf2.TYPES.bool:
                  return str === 'true';
                case ProtoBuf2.TYPES.string:
                  return this.verifyValue(str);
                case ProtoBuf2.TYPES.bytes:
                  return ByteBuffer.fromBinary(str);
              }
            }),
            (ElementPrototype.valueToString = function (value) {
              if (!this.isMapKey) throw Error('valueToString() called on non-map-key element');
              return this.type === ProtoBuf2.TYPES.bytes ? value.toString('binary') : value.toString();
            }),
            (Reflect2.Element = Element));
          var Message = function (builder, parent, name, options, isGroup, syntax) {
              (Namespace.call(this, builder, parent, name, options, syntax),
                (this.className = 'Message'),
                (this.extensions = void 0),
                (this.clazz = null),
                (this.isGroup = !!isGroup),
                (this._fields = null),
                (this._fieldsById = null),
                (this._fieldsByName = null));
            },
            MessagePrototype = (Message.prototype = Object.create(Namespace.prototype));
          ((MessagePrototype.build = function (rebuild) {
            if (this.clazz && !rebuild) return this.clazz;
            var clazz = (function (ProtoBuf3, T2) {
              var fields = T2.getChildren(ProtoBuf3.Reflect.Message.Field),
                oneofs = T2.getChildren(ProtoBuf3.Reflect.Message.OneOf),
                Message2 = function (values, var_args) {
                  ProtoBuf3.Builder.Message.call(this);
                  for (var i3 = 0, k2 = oneofs.length; i3 < k2; ++i3) this[oneofs[i3].name] = null;
                  for (i3 = 0, k2 = fields.length; i3 < k2; ++i3) {
                    var field2 = fields[i3];
                    ((this[field2.name] = field2.repeated ? [] : field2.map ? new ProtoBuf3.Map(field2) : null),
                      (field2.required || T2.syntax === 'proto3') &&
                        field2.defaultValue !== null &&
                        (this[field2.name] = field2.defaultValue));
                  }
                  if (arguments.length > 0) {
                    var value;
                    if (
                      arguments.length === 1 &&
                      values !== null &&
                      typeof values == 'object' &&
                      (typeof values.encode != 'function' || values instanceof Message2) &&
                      !Array.isArray(values) &&
                      !(values instanceof ProtoBuf3.Map) &&
                      !ByteBuffer.isByteBuffer(values) &&
                      !(values instanceof ArrayBuffer) &&
                      !(ProtoBuf3.Long && values instanceof ProtoBuf3.Long)
                    )
                      this.$set(values);
                    else
                      for (i3 = 0, k2 = arguments.length; i3 < k2; ++i3)
                        typeof (value = arguments[i3]) < 'u' && this.$set(fields[i3].name, value);
                  }
                },
                MessagePrototype2 = (Message2.prototype = Object.create(ProtoBuf3.Builder.Message.prototype));
              ((MessagePrototype2.add = function (key, value, noAssert) {
                var field2 = T2._fieldsByName[key];
                if (!noAssert) {
                  if (!field2) throw Error(this + '#' + key + ' is undefined');
                  if (!(field2 instanceof ProtoBuf3.Reflect.Message.Field))
                    throw Error(this + '#' + key + ' is not a field: ' + field2.toString(!0));
                  if (!field2.repeated) throw Error(this + '#' + key + ' is not a repeated field');
                  value = field2.verifyValue(value, !0);
                }
                return (this[key] === null && (this[key] = []), this[key].push(value), this);
              }),
                (MessagePrototype2.$add = MessagePrototype2.add),
                (MessagePrototype2.set = function (keyOrObj, value, noAssert) {
                  if (keyOrObj && typeof keyOrObj == 'object') {
                    noAssert = value;
                    for (var ikey in keyOrObj)
                      keyOrObj.hasOwnProperty(ikey) &&
                        typeof (value = keyOrObj[ikey]) < 'u' &&
                        T2._oneofsByName[ikey] === void 0 &&
                        this.$set(ikey, value, noAssert);
                    return this;
                  }
                  var field2 = T2._fieldsByName[keyOrObj];
                  if (noAssert) this[keyOrObj] = value;
                  else {
                    if (!field2) throw Error(this + '#' + keyOrObj + ' is not a field: undefined');
                    if (!(field2 instanceof ProtoBuf3.Reflect.Message.Field))
                      throw Error(this + '#' + keyOrObj + ' is not a field: ' + field2.toString(!0));
                    this[field2.name] = value = field2.verifyValue(value);
                  }
                  if (field2 && field2.oneof) {
                    var currentField = this[field2.oneof.name];
                    value !== null
                      ? (currentField !== null && currentField !== field2.name && (this[currentField] = null),
                        (this[field2.oneof.name] = field2.name))
                      : currentField === keyOrObj && (this[field2.oneof.name] = null);
                  }
                  return this;
                }),
                (MessagePrototype2.$set = MessagePrototype2.set),
                (MessagePrototype2.get = function (key, noAssert) {
                  if (noAssert) return this[key];
                  var field2 = T2._fieldsByName[key];
                  if (!field2 || !(field2 instanceof ProtoBuf3.Reflect.Message.Field))
                    throw Error(this + '#' + key + ' is not a field: undefined');
                  if (!(field2 instanceof ProtoBuf3.Reflect.Message.Field))
                    throw Error(this + '#' + key + ' is not a field: ' + field2.toString(!0));
                  return this[field2.name];
                }),
                (MessagePrototype2.$get = MessagePrototype2.get));
              for (var i2 = 0; i2 < fields.length; i2++) {
                var field = fields[i2];
                field instanceof ProtoBuf3.Reflect.Message.ExtensionField ||
                  (T2.builder.options.populateAccessors &&
                    (function (field2) {
                      var Name = field2.originalName.replace(/(_[a-zA-Z])/g, function (match) {
                        return match.toUpperCase().replace('_', '');
                      });
                      Name = Name.substring(0, 1).toUpperCase() + Name.substring(1);
                      var name = field2.originalName.replace(/([A-Z])/g, function (match) {
                          return '_' + match;
                        }),
                        setter = function (value, noAssert) {
                          return ((this[field2.name] = noAssert ? value : field2.verifyValue(value)), this);
                        },
                        getter = function () {
                          return this[field2.name];
                        };
                      (T2.getChild('set' + Name) === null && (MessagePrototype2['set' + Name] = setter),
                        T2.getChild('set_' + name) === null && (MessagePrototype2['set_' + name] = setter),
                        T2.getChild('get' + Name) === null && (MessagePrototype2['get' + Name] = getter),
                        T2.getChild('get_' + name) === null && (MessagePrototype2['get_' + name] = getter));
                    })(field));
              }
              ((MessagePrototype2.encode = function (buffer, noVerify) {
                typeof buffer == 'boolean' && ((noVerify = buffer), (buffer = void 0));
                var isNew = !1;
                buffer || ((buffer = new ByteBuffer()), (isNew = !0));
                var le = buffer.littleEndian;
                try {
                  return (T2.encode(this, buffer.LE(), noVerify), (isNew ? buffer.flip() : buffer).LE(le));
                } catch (e) {
                  throw (buffer.LE(le), e);
                }
              }),
                (Message2.encode = function (data, buffer, noVerify) {
                  return new Message2(data).encode(buffer, noVerify);
                }),
                (MessagePrototype2.calculate = function () {
                  return T2.calculate(this);
                }),
                (MessagePrototype2.encodeDelimited = function (buffer, noVerify) {
                  var isNew = !1;
                  buffer || ((buffer = new ByteBuffer()), (isNew = !0));
                  var enc = new ByteBuffer().LE();
                  return (
                    T2.encode(this, enc, noVerify).flip(),
                    buffer.writeVarint32(enc.remaining()),
                    buffer.append(enc),
                    isNew ? buffer.flip() : buffer
                  );
                }),
                (MessagePrototype2.encodeAB = function () {
                  try {
                    return this.encode().toArrayBuffer();
                  } catch (e) {
                    throw (e.encoded && (e.encoded = e.encoded.toArrayBuffer()), e);
                  }
                }),
                (MessagePrototype2.toArrayBuffer = MessagePrototype2.encodeAB),
                (MessagePrototype2.encodeNB = function () {
                  try {
                    return this.encode().toBuffer();
                  } catch (e) {
                    throw (e.encoded && (e.encoded = e.encoded.toBuffer()), e);
                  }
                }),
                (MessagePrototype2.toBuffer = MessagePrototype2.encodeNB),
                (MessagePrototype2.encode64 = function () {
                  try {
                    return this.encode().toBase64();
                  } catch (e) {
                    throw (e.encoded && (e.encoded = e.encoded.toBase64()), e);
                  }
                }),
                (MessagePrototype2.toBase64 = MessagePrototype2.encode64),
                (MessagePrototype2.encodeHex = function () {
                  try {
                    return this.encode().toHex();
                  } catch (e) {
                    throw (e.encoded && (e.encoded = e.encoded.toHex()), e);
                  }
                }),
                (MessagePrototype2.toHex = MessagePrototype2.encodeHex));
              function cloneRaw(obj, binaryAsBase64, longsAsStrings, resolvedType) {
                if (obj === null || typeof obj != 'object') {
                  if (resolvedType && resolvedType instanceof ProtoBuf3.Reflect.Enum) {
                    var name = ProtoBuf3.Reflect.Enum.getName(resolvedType.object, obj);
                    if (name !== null) return name;
                  }
                  return obj;
                }
                if (ByteBuffer.isByteBuffer(obj)) return binaryAsBase64 ? obj.toBase64() : obj.toBuffer();
                if (ProtoBuf3.Long.isLong(obj)) return longsAsStrings ? obj.toString() : ProtoBuf3.Long.fromValue(obj);
                var clone;
                if (Array.isArray(obj))
                  return (
                    (clone = []),
                    obj.forEach(function (v, k2) {
                      clone[k2] = cloneRaw(v, binaryAsBase64, longsAsStrings, resolvedType);
                    }),
                    clone
                  );
                if (((clone = {}), obj instanceof ProtoBuf3.Map)) {
                  for (var it = obj.entries(), e = it.next(); !e.done; e = it.next())
                    clone[obj.keyElem.valueToString(e.value[0])] = cloneRaw(
                      e.value[1],
                      binaryAsBase64,
                      longsAsStrings,
                      obj.valueElem.resolvedType
                    );
                  return clone;
                }
                var type = obj.$type,
                  field2 = void 0;
                for (var i3 in obj)
                  obj.hasOwnProperty(i3) &&
                    (type && (field2 = type.getChild(i3))
                      ? (clone[i3] = cloneRaw(obj[i3], binaryAsBase64, longsAsStrings, field2.resolvedType))
                      : (clone[i3] = cloneRaw(obj[i3], binaryAsBase64, longsAsStrings)));
                return clone;
              }
              ((MessagePrototype2.toRaw = function (binaryAsBase64, longsAsStrings) {
                return cloneRaw(this, !!binaryAsBase64, !!longsAsStrings, this.$type);
              }),
                (MessagePrototype2.encodeJSON = function () {
                  return JSON.stringify(cloneRaw(this, !0, !0, this.$type));
                }),
                (Message2.decode = function (buffer, length, enc) {
                  (typeof length == 'string' && ((enc = length), (length = -1)),
                    typeof buffer == 'string'
                      ? (buffer = ByteBuffer.wrap(buffer, enc || 'base64'))
                      : ByteBuffer.isByteBuffer(buffer) || (buffer = ByteBuffer.wrap(buffer)));
                  var le = buffer.littleEndian;
                  try {
                    var msg = T2.decode(buffer.LE(), length);
                    return (buffer.LE(le), msg);
                  } catch (e) {
                    throw (buffer.LE(le), e);
                  }
                }),
                (Message2.decodeDelimited = function (buffer, enc) {
                  if (
                    (typeof buffer == 'string'
                      ? (buffer = ByteBuffer.wrap(buffer, enc || 'base64'))
                      : ByteBuffer.isByteBuffer(buffer) || (buffer = ByteBuffer.wrap(buffer)),
                    buffer.remaining() < 1)
                  )
                    return null;
                  var off = buffer.offset,
                    len = buffer.readVarint32();
                  if (buffer.remaining() < len) return ((buffer.offset = off), null);
                  try {
                    var msg = T2.decode(buffer.slice(buffer.offset, buffer.offset + len).LE());
                    return ((buffer.offset += len), msg);
                  } catch (err) {
                    throw ((buffer.offset += len), err);
                  }
                }),
                (Message2.decode64 = function (str) {
                  return Message2.decode(str, 'base64');
                }),
                (Message2.decodeHex = function (str) {
                  return Message2.decode(str, 'hex');
                }),
                (Message2.decodeJSON = function (str) {
                  return new Message2(JSON.parse(str));
                }),
                (MessagePrototype2.toString = function () {
                  return T2.toString();
                }));
              var $optionsS, $options, $typeS, $type;
              return (
                Object.defineProperty &&
                  (Object.defineProperty(Message2, '$options', { value: T2.buildOpt() }),
                  Object.defineProperty(MessagePrototype2, '$options', { value: Message2.$options }),
                  Object.defineProperty(Message2, '$type', { value: T2 }),
                  Object.defineProperty(MessagePrototype2, '$type', { value: T2 })),
                Message2
              );
            })(ProtoBuf2, this);
            ((this._fields = []), (this._fieldsById = {}), (this._fieldsByName = {}), (this._oneofsByName = {}));
            for (var i = 0, k = this.children.length, child; i < k; i++)
              if (
                ((child = this.children[i]),
                child instanceof Enum || child instanceof Message || child instanceof Service)
              ) {
                if (clazz.hasOwnProperty(child.name))
                  throw Error(
                    'Illegal reflect child of ' +
                      this.toString(!0) +
                      ': ' +
                      child.toString(!0) +
                      " cannot override static property '" +
                      child.name +
                      "'"
                  );
                clazz[child.name] = child.build();
              } else if (child instanceof Message.Field)
                (child.build(),
                  this._fields.push(child),
                  (this._fieldsById[child.id] = child),
                  (this._fieldsByName[child.name] = child));
              else if (child instanceof Message.OneOf) this._oneofsByName[child.name] = child;
              else if (!(child instanceof Message.OneOf) && !(child instanceof Extension))
                throw Error('Illegal reflect child of ' + this.toString(!0) + ': ' + this.children[i].toString(!0));
            return (this.clazz = clazz);
          }),
            (MessagePrototype.encode = function (message, buffer, noVerify) {
              for (var fieldMissing = null, field, i = 0, k = this._fields.length, val; i < k; ++i)
                ((field = this._fields[i]),
                  (val = message[field.name]),
                  field.required && val === null
                    ? fieldMissing === null && (fieldMissing = field)
                    : field.encode(noVerify ? val : field.verifyValue(val), buffer, message));
              if (fieldMissing !== null) {
                var err = Error('Missing at least one required field for ' + this.toString(!0) + ': ' + fieldMissing);
                throw ((err.encoded = buffer), err);
              }
              return buffer;
            }),
            (MessagePrototype.calculate = function (message) {
              for (var n = 0, i = 0, k = this._fields.length, field, val; i < k; ++i) {
                if (((field = this._fields[i]), (val = message[field.name]), field.required && val === null))
                  throw Error('Missing at least one required field for ' + this.toString(!0) + ': ' + field);
                n += field.calculate(val, message);
              }
              return n;
            }));
          function skipTillGroupEnd(expectedId, buf) {
            var tag = buf.readVarint32(),
              wireType = tag & 7,
              id = tag >>> 3;
            switch (wireType) {
              case ProtoBuf2.WIRE_TYPES.VARINT:
                do tag = buf.readUint8();
                while ((tag & 128) === 128);
                break;
              case ProtoBuf2.WIRE_TYPES.BITS64:
                buf.offset += 8;
                break;
              case ProtoBuf2.WIRE_TYPES.LDELIM:
                ((tag = buf.readVarint32()), (buf.offset += tag));
                break;
              case ProtoBuf2.WIRE_TYPES.STARTGROUP:
                skipTillGroupEnd(id, buf);
                break;
              case ProtoBuf2.WIRE_TYPES.ENDGROUP:
                if (id === expectedId) return !1;
                throw Error('Illegal GROUPEND after unknown group: ' + id + ' (' + expectedId + ' expected)');
              case ProtoBuf2.WIRE_TYPES.BITS32:
                buf.offset += 4;
                break;
              default:
                throw Error('Illegal wire type in unknown group ' + expectedId + ': ' + wireType);
            }
            return !0;
          }
          ((MessagePrototype.decode = function (buffer, length, expectedGroupEndId) {
            typeof length != 'number' && (length = -1);
            for (
              var start = buffer.offset, msg = new this.clazz(), tag, wireType, id, field;
              buffer.offset < start + length || (length === -1 && buffer.remaining() > 0);
            ) {
              if (
                ((tag = buffer.readVarint32()),
                (wireType = tag & 7),
                (id = tag >>> 3),
                wireType === ProtoBuf2.WIRE_TYPES.ENDGROUP)
              ) {
                if (id !== expectedGroupEndId)
                  throw Error(
                    'Illegal group end indicator for ' +
                      this.toString(!0) +
                      ': ' +
                      id +
                      ' (' +
                      (expectedGroupEndId ? expectedGroupEndId + ' expected' : 'not a group') +
                      ')'
                  );
                break;
              }
              if (!(field = this._fieldsById[id])) {
                switch (wireType) {
                  case ProtoBuf2.WIRE_TYPES.VARINT:
                    buffer.readVarint32();
                    break;
                  case ProtoBuf2.WIRE_TYPES.BITS32:
                    buffer.offset += 4;
                    break;
                  case ProtoBuf2.WIRE_TYPES.BITS64:
                    buffer.offset += 8;
                    break;
                  case ProtoBuf2.WIRE_TYPES.LDELIM:
                    var len = buffer.readVarint32();
                    buffer.offset += len;
                    break;
                  case ProtoBuf2.WIRE_TYPES.STARTGROUP:
                    for (; skipTillGroupEnd(id, buffer); );
                    break;
                  default:
                    throw Error(
                      'Illegal wire type for unknown field ' + id + ' in ' + this.toString(!0) + '#decode: ' + wireType
                    );
                }
                continue;
              }
              if (field.repeated && !field.options.packed) msg[field.name].push(field.decode(wireType, buffer));
              else if (field.map) {
                var keyval = field.decode(wireType, buffer);
                msg[field.name].set(keyval[0], keyval[1]);
              } else if (((msg[field.name] = field.decode(wireType, buffer)), field.oneof)) {
                var currentField = msg[field.oneof.name];
                (currentField !== null && currentField !== field.name && (msg[currentField] = null),
                  (msg[field.oneof.name] = field.name));
              }
            }
            for (var i = 0, k = this._fields.length; i < k; ++i)
              if (((field = this._fields[i]), msg[field.name] === null))
                if (this.syntax === 'proto3') msg[field.name] = field.defaultValue;
                else if (field.required) {
                  var err = Error('Missing at least one required field for ' + this.toString(!0) + ': ' + field.name);
                  throw ((err.decoded = msg), err);
                } else
                  ProtoBuf2.populateDefaults && field.defaultValue !== null && (msg[field.name] = field.defaultValue);
            return msg;
          }),
            (Reflect2.Message = Message));
          var Field = function (builder, message, rule, keytype, type, name, id, options, oneof, syntax) {
              (T.call(this, builder, message, name),
                (this.className = 'Message.Field'),
                (this.required = rule === 'required'),
                (this.repeated = rule === 'repeated'),
                (this.map = rule === 'map'),
                (this.keyType = keytype || null),
                (this.type = type),
                (this.resolvedType = null),
                (this.id = id),
                (this.options = options || {}),
                (this.defaultValue = null),
                (this.oneof = oneof || null),
                (this.syntax = syntax || 'proto2'),
                (this.originalName = this.name),
                (this.element = null),
                (this.keyElement = null),
                this.builder.options.convertFieldsToCamelCase &&
                  !(this instanceof Message.ExtensionField) &&
                  (this.name = ProtoBuf2.Util.toCamelCase(this.name)));
            },
            FieldPrototype = (Field.prototype = Object.create(T.prototype));
          ((FieldPrototype.build = function () {
            ((this.element = new Element(this.type, this.resolvedType, !1, this.syntax, this.name)),
              this.map && (this.keyElement = new Element(this.keyType, void 0, !0, this.syntax, this.name)),
              this.syntax === 'proto3' && !this.repeated && !this.map
                ? (this.defaultValue = Element.defaultFieldValue(this.type))
                : typeof this.options.default < 'u' && (this.defaultValue = this.verifyValue(this.options.default)));
          }),
            (FieldPrototype.verifyValue = function (value, skipRepeated) {
              skipRepeated = skipRepeated || !1;
              var self2 = this;
              function fail(val, msg) {
                throw Error(
                  'Illegal value for ' +
                    self2.toString(!0) +
                    ' of type ' +
                    self2.type.name +
                    ': ' +
                    val +
                    ' (' +
                    msg +
                    ')'
                );
              }
              if (value === null)
                return (
                  this.required && fail(typeof value, 'required'),
                  this.syntax === 'proto3' &&
                    this.type !== ProtoBuf2.TYPES.message &&
                    fail(typeof value, 'proto3 field without field presence cannot be null'),
                  null
                );
              var i;
              if (this.repeated && !skipRepeated) {
                Array.isArray(value) || (value = [value]);
                var res = [];
                for (i = 0; i < value.length; i++) res.push(this.element.verifyValue(value[i]));
                return res;
              }
              return this.map && !skipRepeated
                ? value instanceof ProtoBuf2.Map
                  ? value
                  : (value instanceof Object || fail(typeof value, 'expected ProtoBuf.Map or raw object for map field'),
                    new ProtoBuf2.Map(this, value))
                : (!this.repeated && Array.isArray(value) && fail(typeof value, 'no array expected'),
                  this.element.verifyValue(value));
            }),
            (FieldPrototype.hasWirePresence = function (value, message) {
              if (this.syntax !== 'proto3') return value !== null;
              if (this.oneof && message[this.oneof.name] === this.name) return !0;
              switch (this.type) {
                case ProtoBuf2.TYPES.int32:
                case ProtoBuf2.TYPES.sint32:
                case ProtoBuf2.TYPES.sfixed32:
                case ProtoBuf2.TYPES.uint32:
                case ProtoBuf2.TYPES.fixed32:
                  return value !== 0;
                case ProtoBuf2.TYPES.int64:
                case ProtoBuf2.TYPES.sint64:
                case ProtoBuf2.TYPES.sfixed64:
                case ProtoBuf2.TYPES.uint64:
                case ProtoBuf2.TYPES.fixed64:
                  return value.low !== 0 || value.high !== 0;
                case ProtoBuf2.TYPES.bool:
                  return value;
                case ProtoBuf2.TYPES.float:
                case ProtoBuf2.TYPES.double:
                  return value !== 0;
                case ProtoBuf2.TYPES.string:
                  return value.length > 0;
                case ProtoBuf2.TYPES.bytes:
                  return value.remaining() > 0;
                case ProtoBuf2.TYPES.enum:
                  return value !== 0;
                case ProtoBuf2.TYPES.message:
                  return value !== null;
                default:
                  return !0;
              }
            }),
            (FieldPrototype.encode = function (value, buffer, message) {
              if (this.type === null || typeof this.type != 'object')
                throw Error('[INTERNAL] Unresolved type in ' + this.toString(!0) + ': ' + this.type);
              if (value === null || (this.repeated && value.length == 0)) return buffer;
              try {
                if (this.repeated) {
                  var i;
                  if (this.options.packed && ProtoBuf2.PACKABLE_WIRE_TYPES.indexOf(this.type.wireType) >= 0) {
                    (buffer.writeVarint32((this.id << 3) | ProtoBuf2.WIRE_TYPES.LDELIM),
                      buffer.ensureCapacity((buffer.offset += 1)));
                    var start = buffer.offset;
                    for (i = 0; i < value.length; i++) this.element.encodeValue(this.id, value[i], buffer);
                    var len = buffer.offset - start,
                      varintLen = ByteBuffer.calculateVarint32(len);
                    if (varintLen > 1) {
                      var contents = buffer.slice(start, buffer.offset);
                      ((start += varintLen - 1), (buffer.offset = start), buffer.append(contents));
                    }
                    buffer.writeVarint32(len, start - varintLen);
                  } else
                    for (i = 0; i < value.length; i++)
                      (buffer.writeVarint32((this.id << 3) | this.type.wireType),
                        this.element.encodeValue(this.id, value[i], buffer));
                } else
                  this.map
                    ? value.forEach(function (val, key, m) {
                        var length =
                          ByteBuffer.calculateVarint32(8 | this.keyType.wireType) +
                          this.keyElement.calculateLength(1, key) +
                          ByteBuffer.calculateVarint32(16 | this.type.wireType) +
                          this.element.calculateLength(2, val);
                        (buffer.writeVarint32((this.id << 3) | ProtoBuf2.WIRE_TYPES.LDELIM),
                          buffer.writeVarint32(length),
                          buffer.writeVarint32(8 | this.keyType.wireType),
                          this.keyElement.encodeValue(1, key, buffer),
                          buffer.writeVarint32(16 | this.type.wireType),
                          this.element.encodeValue(2, val, buffer));
                      }, this)
                    : this.hasWirePresence(value, message) &&
                      (buffer.writeVarint32((this.id << 3) | this.type.wireType),
                      this.element.encodeValue(this.id, value, buffer));
              } catch (e) {
                throw Error('Illegal value for ' + this.toString(!0) + ': ' + value + ' (' + e + ')');
              }
              return buffer;
            }),
            (FieldPrototype.calculate = function (value, message) {
              if (((value = this.verifyValue(value)), this.type === null || typeof this.type != 'object'))
                throw Error('[INTERNAL] Unresolved type in ' + this.toString(!0) + ': ' + this.type);
              if (value === null || (this.repeated && value.length == 0)) return 0;
              var n = 0;
              try {
                if (this.repeated) {
                  var i, ni;
                  if (this.options.packed && ProtoBuf2.PACKABLE_WIRE_TYPES.indexOf(this.type.wireType) >= 0) {
                    for (
                      n += ByteBuffer.calculateVarint32((this.id << 3) | ProtoBuf2.WIRE_TYPES.LDELIM), ni = 0, i = 0;
                      i < value.length;
                      i++
                    )
                      ni += this.element.calculateLength(this.id, value[i]);
                    ((n += ByteBuffer.calculateVarint32(ni)), (n += ni));
                  } else
                    for (i = 0; i < value.length; i++)
                      ((n += ByteBuffer.calculateVarint32((this.id << 3) | this.type.wireType)),
                        (n += this.element.calculateLength(this.id, value[i])));
                } else
                  this.map
                    ? value.forEach(function (val, key, m) {
                        var length =
                          ByteBuffer.calculateVarint32(8 | this.keyType.wireType) +
                          this.keyElement.calculateLength(1, key) +
                          ByteBuffer.calculateVarint32(16 | this.type.wireType) +
                          this.element.calculateLength(2, val);
                        ((n += ByteBuffer.calculateVarint32((this.id << 3) | ProtoBuf2.WIRE_TYPES.LDELIM)),
                          (n += ByteBuffer.calculateVarint32(length)),
                          (n += length));
                      }, this)
                    : this.hasWirePresence(value, message) &&
                      ((n += ByteBuffer.calculateVarint32((this.id << 3) | this.type.wireType)),
                      (n += this.element.calculateLength(this.id, value)));
              } catch (e) {
                throw Error('Illegal value for ' + this.toString(!0) + ': ' + value + ' (' + e + ')');
              }
              return n;
            }),
            (FieldPrototype.decode = function (wireType, buffer, skipRepeated) {
              var value,
                nBytes,
                wireTypeOK =
                  (!this.map && wireType == this.type.wireType) ||
                  (!skipRepeated && this.repeated && this.options.packed && wireType == ProtoBuf2.WIRE_TYPES.LDELIM) ||
                  (this.map && wireType == ProtoBuf2.WIRE_TYPES.LDELIM);
              if (!wireTypeOK)
                throw Error(
                  'Illegal wire type for field ' +
                    this.toString(!0) +
                    ': ' +
                    wireType +
                    ' (' +
                    this.type.wireType +
                    ' expected)'
                );
              if (
                wireType == ProtoBuf2.WIRE_TYPES.LDELIM &&
                this.repeated &&
                this.options.packed &&
                ProtoBuf2.PACKABLE_WIRE_TYPES.indexOf(this.type.wireType) >= 0 &&
                !skipRepeated
              ) {
                ((nBytes = buffer.readVarint32()), (nBytes = buffer.offset + nBytes));
                for (var values = []; buffer.offset < nBytes; )
                  values.push(this.decode(this.type.wireType, buffer, !0));
                return values;
              }
              if (this.map) {
                var key = Element.defaultFieldValue(this.keyType);
                if (
                  ((value = Element.defaultFieldValue(this.type)),
                  (nBytes = buffer.readVarint32()),
                  buffer.remaining() < nBytes)
                )
                  throw Error(
                    'Illegal number of bytes for ' +
                      this.toString(!0) +
                      ': ' +
                      nBytes +
                      ' required but got only ' +
                      buffer.remaining()
                  );
                var msgbuf = buffer.clone();
                for (msgbuf.limit = msgbuf.offset + nBytes, buffer.offset += nBytes; msgbuf.remaining() > 0; ) {
                  var tag = msgbuf.readVarint32();
                  wireType = tag & 7;
                  var id = tag >>> 3;
                  if (id === 1) key = this.keyElement.decode(msgbuf, wireType, id);
                  else if (id === 2) value = this.element.decode(msgbuf, wireType, id);
                  else throw Error('Unexpected tag in map field key/value submessage');
                }
                return [key, value];
              }
              return this.element.decode(buffer, wireType, this.id);
            }),
            (Reflect2.Message.Field = Field));
          var ExtensionField = function (builder, message, rule, type, name, id, options) {
            (Field.call(this, builder, message, rule, null, type, name, id, options), this.extension);
          };
          ((ExtensionField.prototype = Object.create(Field.prototype)),
            (Reflect2.Message.ExtensionField = ExtensionField));
          var OneOf = function (builder, message, name) {
            (T.call(this, builder, message, name), (this.fields = []));
          };
          Reflect2.Message.OneOf = OneOf;
          var Enum = function (builder, parent, name, options, syntax) {
            (Namespace.call(this, builder, parent, name, options, syntax),
              (this.className = 'Enum'),
              (this.object = null));
          };
          Enum.getName = function (enm, value) {
            for (var keys = Object.keys(enm), i = 0, key; i < keys.length; ++i)
              if (enm[(key = keys[i])] === value) return key;
            return null;
          };
          var EnumPrototype = (Enum.prototype = Object.create(Namespace.prototype));
          ((EnumPrototype.build = function (rebuild) {
            if (this.object && !rebuild) return this.object;
            for (
              var enm = new ProtoBuf2.Builder.Enum(), values = this.getChildren(Enum.Value), i = 0, k = values.length;
              i < k;
              ++i
            )
              enm[values[i].name] = values[i].id;
            return (
              Object.defineProperty &&
                Object.defineProperty(enm, '$options', { value: this.buildOpt(), enumerable: !1 }),
              (this.object = enm)
            );
          }),
            (Reflect2.Enum = Enum));
          var Value = function (builder, enm, name, id) {
            (T.call(this, builder, enm, name), (this.className = 'Enum.Value'), (this.id = id));
          };
          ((Value.prototype = Object.create(T.prototype)), (Reflect2.Enum.Value = Value));
          var Extension = function (builder, parent, name, field) {
            (T.call(this, builder, parent, name), (this.field = field));
          };
          ((Extension.prototype = Object.create(T.prototype)), (Reflect2.Extension = Extension));
          var Service = function (builder, root, name, options) {
              (Namespace.call(this, builder, root, name, options), (this.className = 'Service'), (this.clazz = null));
            },
            ServicePrototype = (Service.prototype = Object.create(Namespace.prototype));
          ((ServicePrototype.build = function (rebuild) {
            return this.clazz && !rebuild
              ? this.clazz
              : (this.clazz = (function (ProtoBuf3, T2) {
                  for (
                    var Service2 = function (rpcImpl) {
                        (ProtoBuf3.Builder.Service.call(this),
                          (this.rpcImpl =
                            rpcImpl ||
                            function (name, msg, callback) {
                              setTimeout(
                                callback.bind(
                                  this,
                                  Error('Not implemented, see: https://github.com/dcodeIO/ProtoBuf.js/wiki/Services')
                                ),
                                0
                              );
                            }));
                      },
                      ServicePrototype2 = (Service2.prototype = Object.create(ProtoBuf3.Builder.Service.prototype)),
                      rpc = T2.getChildren(ProtoBuf3.Reflect.Service.RPCMethod),
                      i = 0;
                    i < rpc.length;
                    i++
                  )
                    (function (method) {
                      ((ServicePrototype2[method.name] = function (req, callback) {
                        try {
                          try {
                            req = method.resolvedRequestType.clazz.decode(ByteBuffer.wrap(req));
                          } catch (err) {
                            if (!(err instanceof TypeError)) throw err;
                          }
                          if (req === null || typeof req != 'object') throw Error('Illegal arguments');
                          (req instanceof method.resolvedRequestType.clazz ||
                            (req = new method.resolvedRequestType.clazz(req)),
                            this.rpcImpl(method.fqn(), req, function (err, res) {
                              if (err) {
                                callback(err);
                                return;
                              }
                              res === null && (res = '');
                              try {
                                res = method.resolvedResponseType.clazz.decode(res);
                              } catch {}
                              if (!res || !(res instanceof method.resolvedResponseType.clazz)) {
                                callback(
                                  Error(
                                    'Illegal response type received in service method ' + T2.name + '#' + method.name
                                  )
                                );
                                return;
                              }
                              callback(null, res);
                            }));
                        } catch (err) {
                          setTimeout(callback.bind(this, err), 0);
                        }
                      }),
                        (Service2[method.name] = function (rpcImpl, req, callback) {
                          new Service2(rpcImpl)[method.name](req, callback);
                        }),
                        Object.defineProperty &&
                          (Object.defineProperty(Service2[method.name], '$options', { value: method.buildOpt() }),
                          Object.defineProperty(ServicePrototype2[method.name], '$options', {
                            value: Service2[method.name].$options,
                          })));
                    })(rpc[i]);
                  var $optionsS, $options, $typeS, $type;
                  return (
                    Object.defineProperty &&
                      (Object.defineProperty(Service2, '$options', { value: T2.buildOpt() }),
                      Object.defineProperty(ServicePrototype2, '$options', { value: Service2.$options }),
                      Object.defineProperty(Service2, '$type', { value: T2 }),
                      Object.defineProperty(ServicePrototype2, '$type', { value: T2 })),
                    Service2
                  );
                })(ProtoBuf2, this));
          }),
            (Reflect2.Service = Service));
          var Method = function (builder, svc, name, options) {
              (T.call(this, builder, svc, name), (this.className = 'Service.Method'), (this.options = options || {}));
            },
            MethodPrototype = (Method.prototype = Object.create(T.prototype));
          ((MethodPrototype.buildOpt = NamespacePrototype.buildOpt), (Reflect2.Service.Method = Method));
          var RPCMethod = function (builder, svc, name, request, response, request_stream, response_stream, options) {
            (Method.call(this, builder, svc, name, options),
              (this.className = 'Service.RPCMethod'),
              (this.requestName = request),
              (this.responseName = response),
              (this.requestStream = request_stream),
              (this.responseStream = response_stream),
              (this.resolvedRequestType = null),
              (this.resolvedResponseType = null));
          };
          return (
            (RPCMethod.prototype = Object.create(Method.prototype)),
            (Reflect2.Service.RPCMethod = RPCMethod),
            Reflect2
          );
        })(ProtoBuf)),
        (ProtoBuf.Builder = (function (ProtoBuf2, Lang, Reflect2) {
          'use strict';
          var Builder = function (options) {
              ((this.ns = new Reflect2.Namespace(this, null, '')),
                (this.ptr = this.ns),
                (this.resolved = !1),
                (this.result = null),
                (this.files = {}),
                (this.importRoot = null),
                (this.options = options || {}));
            },
            BuilderPrototype = Builder.prototype;
          ((Builder.isMessage = function (def) {
            return !(typeof def.name != 'string' || typeof def.values < 'u' || typeof def.rpc < 'u');
          }),
            (Builder.isMessageField = function (def) {
              return !(
                typeof def.rule != 'string' ||
                typeof def.name != 'string' ||
                typeof def.type != 'string' ||
                typeof def.id > 'u'
              );
            }),
            (Builder.isEnum = function (def) {
              return !(
                typeof def.name != 'string' ||
                typeof def.values > 'u' ||
                !Array.isArray(def.values) ||
                def.values.length === 0
              );
            }),
            (Builder.isService = function (def) {
              return !(typeof def.name != 'string' || typeof def.rpc != 'object' || !def.rpc);
            }),
            (Builder.isExtend = function (def) {
              return typeof def.ref == 'string';
            }),
            (BuilderPrototype.reset = function () {
              return ((this.ptr = this.ns), this);
            }),
            (BuilderPrototype.define = function (namespace) {
              if (typeof namespace != 'string' || !Lang.TYPEREF.test(namespace))
                throw Error('illegal namespace: ' + namespace);
              return (
                namespace.split('.').forEach(function (part) {
                  var ns = this.ptr.getChild(part);
                  (ns === null && this.ptr.addChild((ns = new Reflect2.Namespace(this, this.ptr, part))),
                    (this.ptr = ns));
                }, this),
                this
              );
            }),
            (BuilderPrototype.create = function (defs) {
              if (!defs) return this;
              if (!Array.isArray(defs)) defs = [defs];
              else {
                if (defs.length === 0) return this;
                defs = defs.slice();
              }
              for (var stack = [defs]; stack.length > 0; ) {
                if (((defs = stack.pop()), !Array.isArray(defs)))
                  throw Error('not a valid namespace: ' + JSON.stringify(defs));
                for (; defs.length > 0; ) {
                  var def = defs.shift();
                  if (Builder.isMessage(def)) {
                    var obj = new Reflect2.Message(this, this.ptr, def.name, def.options, def.isGroup, def.syntax),
                      oneofs = {};
                    (def.oneofs &&
                      Object.keys(def.oneofs).forEach(function (name) {
                        obj.addChild((oneofs[name] = new Reflect2.Message.OneOf(this, obj, name)));
                      }, this),
                      def.fields &&
                        def.fields.forEach(function (fld) {
                          if (obj.getChild(fld.id | 0) !== null)
                            throw Error('duplicate or invalid field id in ' + obj.name + ': ' + fld.id);
                          if (fld.options && typeof fld.options != 'object')
                            throw Error('illegal field options in ' + obj.name + '#' + fld.name);
                          var oneof = null;
                          if (typeof fld.oneof == 'string' && !(oneof = oneofs[fld.oneof]))
                            throw Error('illegal oneof in ' + obj.name + '#' + fld.name + ': ' + fld.oneof);
                          ((fld = new Reflect2.Message.Field(
                            this,
                            obj,
                            fld.rule,
                            fld.keytype,
                            fld.type,
                            fld.name,
                            fld.id,
                            fld.options,
                            oneof,
                            def.syntax
                          )),
                            oneof && oneof.fields.push(fld),
                            obj.addChild(fld));
                        }, this));
                    var subObj = [];
                    if (
                      (def.enums &&
                        def.enums.forEach(function (enm) {
                          subObj.push(enm);
                        }),
                      def.messages &&
                        def.messages.forEach(function (msg) {
                          subObj.push(msg);
                        }),
                      def.services &&
                        def.services.forEach(function (svc) {
                          subObj.push(svc);
                        }),
                      def.extensions &&
                        (typeof def.extensions[0] == 'number'
                          ? (obj.extensions = [def.extensions])
                          : (obj.extensions = def.extensions)),
                      this.ptr.addChild(obj),
                      subObj.length > 0)
                    ) {
                      (stack.push(defs), (defs = subObj), (subObj = null), (this.ptr = obj), (obj = null));
                      continue;
                    }
                    subObj = null;
                  } else if (Builder.isEnum(def))
                    ((obj = new Reflect2.Enum(this, this.ptr, def.name, def.options, def.syntax)),
                      def.values.forEach(function (val) {
                        obj.addChild(new Reflect2.Enum.Value(this, obj, val.name, val.id));
                      }, this),
                      this.ptr.addChild(obj));
                  else if (Builder.isService(def))
                    ((obj = new Reflect2.Service(this, this.ptr, def.name, def.options)),
                      Object.keys(def.rpc).forEach(function (name) {
                        var mtd = def.rpc[name];
                        obj.addChild(
                          new Reflect2.Service.RPCMethod(
                            this,
                            obj,
                            name,
                            mtd.request,
                            mtd.response,
                            !!mtd.request_stream,
                            !!mtd.response_stream,
                            mtd.options
                          )
                        );
                      }, this),
                      this.ptr.addChild(obj));
                  else if (Builder.isExtend(def)) {
                    if (((obj = this.ptr.resolve(def.ref, !0)), obj))
                      def.fields.forEach(function (fld) {
                        if (obj.getChild(fld.id | 0) !== null)
                          throw Error('duplicate extended field id in ' + obj.name + ': ' + fld.id);
                        if (obj.extensions) {
                          var valid = !1;
                          if (
                            (obj.extensions.forEach(function (range) {
                              fld.id >= range[0] && fld.id <= range[1] && (valid = !0);
                            }),
                            !valid)
                          )
                            throw Error(
                              'illegal extended field id in ' + obj.name + ': ' + fld.id + ' (not within valid ranges)'
                            );
                        }
                        var name = fld.name;
                        this.options.convertFieldsToCamelCase && (name = ProtoBuf2.Util.toCamelCase(name));
                        var field = new Reflect2.Message.ExtensionField(
                            this,
                            obj,
                            fld.rule,
                            fld.type,
                            this.ptr.fqn() + '.' + name,
                            fld.id,
                            fld.options
                          ),
                          ext = new Reflect2.Extension(this, this.ptr, fld.name, field);
                        ((field.extension = ext), this.ptr.addChild(ext), obj.addChild(field));
                      }, this);
                    else if (!/\.?google\.protobuf\./.test(def.ref))
                      throw Error('extended message ' + def.ref + ' is not defined');
                  } else throw Error('not a valid definition: ' + JSON.stringify(def));
                  ((def = null), (obj = null));
                }
                ((defs = null), (this.ptr = this.ptr.parent));
              }
              return ((this.resolved = !1), (this.result = null), this);
            }));
          function propagateSyntax(parent) {
            (parent.messages &&
              parent.messages.forEach(function (child) {
                ((child.syntax = parent.syntax), propagateSyntax(child));
              }),
              parent.enums &&
                parent.enums.forEach(function (child) {
                  child.syntax = parent.syntax;
                }));
          }
          return (
            (BuilderPrototype.import = function (json, filename) {
              var delim = '/';
              if (typeof filename == 'string') {
                if (
                  (ProtoBuf2.Util.IS_NODE && (filename = require('path').resolve(filename)),
                  this.files[filename] === !0)
                )
                  return this.reset();
                this.files[filename] = !0;
              } else if (typeof filename == 'object') {
                var root = filename.root;
                (ProtoBuf2.Util.IS_NODE && (root = require('path').resolve(root)),
                  (root.indexOf('\\') >= 0 || filename.file.indexOf('\\') >= 0) && (delim = '\\'));
                var fname;
                if (
                  (ProtoBuf2.Util.IS_NODE
                    ? (fname = require('path').join(root, filename.file))
                    : (fname = root + delim + filename.file),
                  this.files[fname] === !0)
                )
                  return this.reset();
                this.files[fname] = !0;
              }
              if (json.imports && json.imports.length > 0) {
                var importRoot,
                  resetRoot = !1;
                typeof filename == 'object'
                  ? ((this.importRoot = filename.root),
                    (resetRoot = !0),
                    (importRoot = this.importRoot),
                    (filename = filename.file),
                    (importRoot.indexOf('\\') >= 0 || filename.indexOf('\\') >= 0) && (delim = '\\'))
                  : typeof filename == 'string'
                    ? this.importRoot
                      ? (importRoot = this.importRoot)
                      : filename.indexOf('/') >= 0
                        ? ((importRoot = filename.replace(/\/[^\/]*$/, '')), importRoot === '' && (importRoot = '/'))
                        : filename.indexOf('\\') >= 0
                          ? ((importRoot = filename.replace(/\\[^\\]*$/, '')), (delim = '\\'))
                          : (importRoot = '.')
                    : (importRoot = null);
                for (var i = 0; i < json.imports.length; i++)
                  if (typeof json.imports[i] == 'string') {
                    if (!importRoot) throw Error('cannot determine import root');
                    var importFilename = json.imports[i];
                    if (
                      importFilename === 'google/protobuf/descriptor.proto' ||
                      (ProtoBuf2.Util.IS_NODE
                        ? (importFilename = require('path').join(importRoot, importFilename))
                        : (importFilename = importRoot + delim + importFilename),
                      this.files[importFilename] === !0)
                    )
                      continue;
                    /\.proto$/i.test(importFilename) &&
                      !ProtoBuf2.DotProto &&
                      (importFilename = importFilename.replace(/\.proto$/, '.json'));
                    var contents = ProtoBuf2.Util.fetch(importFilename);
                    if (contents === null)
                      throw Error("failed to import '" + importFilename + "' in '" + filename + "': file not found");
                    /\.json$/i.test(importFilename)
                      ? this.import(JSON.parse(contents + ''), importFilename)
                      : this.import(ProtoBuf2.DotProto.Parser.parse(contents), importFilename);
                  } else
                    filename
                      ? /\.(\w+)$/.test(filename)
                        ? this.import(
                            json.imports[i],
                            filename.replace(/^(.+)\.(\w+)$/, function ($0, $1, $2) {
                              return $1 + '_import' + i + '.' + $2;
                            })
                          )
                        : this.import(json.imports[i], filename + '_import' + i)
                      : this.import(json.imports[i]);
                resetRoot && (this.importRoot = null);
              }
              (json.package && this.define(json.package), json.syntax && propagateSyntax(json));
              var base = this.ptr;
              return (
                json.options &&
                  Object.keys(json.options).forEach(function (key) {
                    base.options[key] = json.options[key];
                  }),
                json.messages && (this.create(json.messages), (this.ptr = base)),
                json.enums && (this.create(json.enums), (this.ptr = base)),
                json.services && (this.create(json.services), (this.ptr = base)),
                json.extends && this.create(json.extends),
                this.reset()
              );
            }),
            (BuilderPrototype.resolveAll = function () {
              var res;
              if (this.ptr == null || typeof this.ptr.type == 'object') return this;
              if (this.ptr instanceof Reflect2.Namespace)
                this.ptr.children.forEach(function (child) {
                  ((this.ptr = child), this.resolveAll());
                }, this);
              else if (this.ptr instanceof Reflect2.Message.Field) {
                if (Lang.TYPE.test(this.ptr.type)) this.ptr.type = ProtoBuf2.TYPES[this.ptr.type];
                else {
                  if (!Lang.TYPEREF.test(this.ptr.type))
                    throw Error('illegal type reference in ' + this.ptr.toString(!0) + ': ' + this.ptr.type);
                  if (
                    ((res = (
                      this.ptr instanceof Reflect2.Message.ExtensionField ? this.ptr.extension.parent : this.ptr.parent
                    ).resolve(this.ptr.type, !0)),
                    !res)
                  )
                    throw Error('unresolvable type reference in ' + this.ptr.toString(!0) + ': ' + this.ptr.type);
                  if (((this.ptr.resolvedType = res), res instanceof Reflect2.Enum)) {
                    if (
                      ((this.ptr.type = ProtoBuf2.TYPES.enum), this.ptr.syntax === 'proto3' && res.syntax !== 'proto3')
                    )
                      throw Error('proto3 message cannot reference proto2 enum');
                  } else if (res instanceof Reflect2.Message)
                    this.ptr.type = res.isGroup ? ProtoBuf2.TYPES.group : ProtoBuf2.TYPES.message;
                  else throw Error('illegal type reference in ' + this.ptr.toString(!0) + ': ' + this.ptr.type);
                }
                if (this.ptr.map) {
                  if (!Lang.TYPE.test(this.ptr.keyType))
                    throw Error('illegal key type for map field in ' + this.ptr.toString(!0) + ': ' + this.ptr.keyType);
                  this.ptr.keyType = ProtoBuf2.TYPES[this.ptr.keyType];
                }
                this.ptr.syntax === 'proto3' &&
                  this.ptr.repeated &&
                  this.ptr.options.packed === void 0 &&
                  ProtoBuf2.PACKABLE_WIRE_TYPES.indexOf(this.ptr.type.wireType) !== -1 &&
                  (this.ptr.options.packed = !0);
              } else if (this.ptr instanceof ProtoBuf2.Reflect.Service.Method)
                if (this.ptr instanceof ProtoBuf2.Reflect.Service.RPCMethod) {
                  if (
                    ((res = this.ptr.parent.resolve(this.ptr.requestName, !0)),
                    !res || !(res instanceof ProtoBuf2.Reflect.Message))
                  )
                    throw Error('Illegal type reference in ' + this.ptr.toString(!0) + ': ' + this.ptr.requestName);
                  if (
                    ((this.ptr.resolvedRequestType = res),
                    (res = this.ptr.parent.resolve(this.ptr.responseName, !0)),
                    !res || !(res instanceof ProtoBuf2.Reflect.Message))
                  )
                    throw Error('Illegal type reference in ' + this.ptr.toString(!0) + ': ' + this.ptr.responseName);
                  this.ptr.resolvedResponseType = res;
                } else throw Error('illegal service type in ' + this.ptr.toString(!0));
              else if (
                !(this.ptr instanceof ProtoBuf2.Reflect.Message.OneOf) &&
                !(this.ptr instanceof ProtoBuf2.Reflect.Extension) &&
                !(this.ptr instanceof ProtoBuf2.Reflect.Enum.Value)
              )
                throw Error('illegal object in namespace: ' + typeof this.ptr + ': ' + this.ptr);
              return this.reset();
            }),
            (BuilderPrototype.build = function (path) {
              if (
                (this.reset(),
                this.resolved || (this.resolveAll(), (this.resolved = !0), (this.result = null)),
                this.result === null && (this.result = this.ns.build()),
                !path)
              )
                return this.result;
              for (
                var part = typeof path == 'string' ? path.split('.') : path, ptr = this.result, i = 0;
                i < part.length;
                i++
              )
                if (ptr[part[i]]) ptr = ptr[part[i]];
                else {
                  ptr = null;
                  break;
                }
              return ptr;
            }),
            (BuilderPrototype.lookup = function (path, excludeNonNamespace) {
              return path ? this.ns.resolve(path, excludeNonNamespace) : this.ns;
            }),
            (BuilderPrototype.toString = function () {
              return 'Builder';
            }),
            (Builder.Message = function () {}),
            (Builder.Enum = function () {}),
            (Builder.Service = function () {}),
            Builder
          );
        })(ProtoBuf, ProtoBuf.Lang, ProtoBuf.Reflect)),
        (ProtoBuf.Map = (function (ProtoBuf2, Reflect2) {
          'use strict';
          var Map = function (field, contents) {
              if (!field.map) throw Error('field is not a map');
              if (
                ((this.field = field),
                (this.keyElem = new Reflect2.Element(field.keyType, null, !0, field.syntax)),
                (this.valueElem = new Reflect2.Element(field.type, field.resolvedType, !1, field.syntax)),
                (this.map = {}),
                Object.defineProperty(this, 'size', {
                  get: function () {
                    return Object.keys(this.map).length;
                  },
                }),
                contents)
              )
                for (var keys = Object.keys(contents), i = 0; i < keys.length; i++) {
                  var key = this.keyElem.valueFromString(keys[i]),
                    val = this.valueElem.verifyValue(contents[keys[i]]);
                  this.map[this.keyElem.valueToString(key)] = { key, value: val };
                }
            },
            MapPrototype = Map.prototype;
          function arrayIterator(arr) {
            var idx = 0;
            return {
              next: function () {
                return idx < arr.length ? { done: !1, value: arr[idx++] } : { done: !0 };
              },
            };
          }
          return (
            (MapPrototype.clear = function () {
              this.map = {};
            }),
            (MapPrototype.delete = function (key) {
              var keyValue = this.keyElem.valueToString(this.keyElem.verifyValue(key)),
                hadKey = keyValue in this.map;
              return (delete this.map[keyValue], hadKey);
            }),
            (MapPrototype.entries = function () {
              for (var entries = [], strKeys = Object.keys(this.map), i = 0, entry; i < strKeys.length; i++)
                entries.push([(entry = this.map[strKeys[i]]).key, entry.value]);
              return arrayIterator(entries);
            }),
            (MapPrototype.keys = function () {
              for (var keys = [], strKeys = Object.keys(this.map), i = 0; i < strKeys.length; i++)
                keys.push(this.map[strKeys[i]].key);
              return arrayIterator(keys);
            }),
            (MapPrototype.values = function () {
              for (var values = [], strKeys = Object.keys(this.map), i = 0; i < strKeys.length; i++)
                values.push(this.map[strKeys[i]].value);
              return arrayIterator(values);
            }),
            (MapPrototype.forEach = function (cb, thisArg) {
              for (var strKeys = Object.keys(this.map), i = 0, entry; i < strKeys.length; i++)
                cb.call(thisArg, (entry = this.map[strKeys[i]]).value, entry.key, this);
            }),
            (MapPrototype.set = function (key, value) {
              var keyValue = this.keyElem.verifyValue(key),
                valValue = this.valueElem.verifyValue(value);
              return ((this.map[this.keyElem.valueToString(keyValue)] = { key: keyValue, value: valValue }), this);
            }),
            (MapPrototype.get = function (key) {
              var keyValue = this.keyElem.valueToString(this.keyElem.verifyValue(key));
              if (keyValue in this.map) return this.map[keyValue].value;
            }),
            (MapPrototype.has = function (key) {
              var keyValue = this.keyElem.valueToString(this.keyElem.verifyValue(key));
              return keyValue in this.map;
            }),
            Map
          );
        })(ProtoBuf, ProtoBuf.Reflect)),
        (ProtoBuf.loadProto = function (proto, builder, filename) {
          return (
            (typeof builder == 'string' ||
              (builder && typeof builder.file == 'string' && typeof builder.root == 'string')) &&
              ((filename = builder), (builder = void 0)),
            ProtoBuf.loadJson(ProtoBuf.DotProto.Parser.parse(proto), builder, filename)
          );
        }),
        (ProtoBuf.protoFromString = ProtoBuf.loadProto),
        (ProtoBuf.loadProtoFile = function (filename, callback, builder) {
          if (
            (callback && typeof callback == 'object'
              ? ((builder = callback), (callback = null))
              : (!callback || typeof callback != 'function') && (callback = null),
            callback)
          )
            return ProtoBuf.Util.fetch(
              typeof filename == 'string' ? filename : filename.root + '/' + filename.file,
              function (contents2) {
                if (contents2 === null) {
                  callback(Error('Failed to fetch file'));
                  return;
                }
                try {
                  callback(null, ProtoBuf.loadProto(contents2, builder, filename));
                } catch (e) {
                  callback(e);
                }
              }
            );
          var contents = ProtoBuf.Util.fetch(
            typeof filename == 'object' ? filename.root + '/' + filename.file : filename
          );
          return contents === null ? null : ProtoBuf.loadProto(contents, builder, filename);
        }),
        (ProtoBuf.protoFromFile = ProtoBuf.loadProtoFile),
        (ProtoBuf.newBuilder = function (options) {
          return (
            (options = options || {}),
            typeof options.convertFieldsToCamelCase > 'u' &&
              (options.convertFieldsToCamelCase = ProtoBuf.convertFieldsToCamelCase),
            typeof options.populateAccessors > 'u' && (options.populateAccessors = ProtoBuf.populateAccessors),
            new ProtoBuf.Builder(options)
          );
        }),
        (ProtoBuf.loadJson = function (json, builder, filename) {
          return (
            (typeof builder == 'string' ||
              (builder && typeof builder.file == 'string' && typeof builder.root == 'string')) &&
              ((filename = builder), (builder = null)),
            (!builder || typeof builder != 'object') && (builder = ProtoBuf.newBuilder()),
            typeof json == 'string' && (json = JSON.parse(json)),
            builder.import(json, filename),
            builder.resolveAll(),
            builder
          );
        }),
        (ProtoBuf.loadJsonFile = function (filename, callback, builder) {
          if (
            (callback && typeof callback == 'object'
              ? ((builder = callback), (callback = null))
              : (!callback || typeof callback != 'function') && (callback = null),
            callback)
          )
            return ProtoBuf.Util.fetch(
              typeof filename == 'string' ? filename : filename.root + '/' + filename.file,
              function (contents2) {
                if (contents2 === null) {
                  callback(Error('Failed to fetch file'));
                  return;
                }
                try {
                  callback(null, ProtoBuf.loadJson(JSON.parse(contents2), builder, filename));
                } catch (e) {
                  callback(e);
                }
              }
            );
          var contents = ProtoBuf.Util.fetch(
            typeof filename == 'object' ? filename.root + '/' + filename.file : filename
          );
          return contents === null ? null : ProtoBuf.loadJson(JSON.parse(contents), builder, filename);
        }),
        ProtoBuf
      );
    });
  },
});
var require_data = __commonJS({
  'node_modules/mumble-streams/lib/data.js'(exports2, module2) {
    'use strict';
    var fs = require('fs'),
      protobufjs = require_protobuf(),
      util = require('util'),
      Transform = require('stream').Transform,
      nameById = {
        0: 'Version',
        1: 'UDPTunnel',
        2: 'Authenticate',
        3: 'Ping',
        4: 'Reject',
        5: 'ServerSync',
        6: 'ChannelRemove',
        7: 'ChannelState',
        8: 'UserRemove',
        9: 'UserState',
        10: 'BanList',
        11: 'TextMessage',
        12: 'PermissionDenied',
        13: 'ACL',
        14: 'QueryUsers',
        15: 'CryptSetup',
        16: 'ContextActionModify',
        17: 'ContextAction',
        18: 'UserList',
        19: 'VoiceTarget',
        20: 'PermissionQuery',
        21: 'CodecVersion',
        22: 'UserStats',
        23: 'RequestBlob',
        24: 'ServerConfig',
        25: 'SuggestConfig',
      },
      idByName = {};
    for (id in nameById) idByName[nameById[id]] = id;
    var id,
      mumbleProto = fs.readFileSync(GetResourcePath(GetCurrentResourceName()) + '/server/vendor/Mumble.proto'),
      messages = protobufjs.loadProto(mumbleProto).build('MumbleProto');
    function encode(name, payload) {
      var encoded = new messages[name](payload || {}).toBuffer();
      return (Buffer.isBuffer(encoded) || (encoded = Buffer.from(encoded)), encoded);
    }
    function decode(id2, payload) {
      var name = nameById[id2];
      return new messages[name].decode(payload || {});
    }
    function Encoder() {
      if (!(this instanceof Encoder)) return new Encoder();
      Transform.call(this, { writableObjectMode: !0 });
    }
    util.inherits(Encoder, Transform);
    Encoder.prototype._transform = function (chunk, encoding, callback) {
      if (typeof chunk.name != 'string') return callback(new TypeError('chunk.name is not a string'));
      chunk.payload = chunk.payload || {};
      var data;
      if (chunk.name == 'UDPTunnel') data = chunk.payload;
      else
        try {
          data = encode(chunk.name, chunk.payload);
        } catch (e) {
          callback(e);
          return;
        }
      var header = Buffer.allocUnsafe(6);
      (header.writeUInt16BE(idByName[chunk.name], 0),
        header.writeUInt32BE(data.length, 2),
        callback(null, Buffer.concat([header, data])));
    };
    function Decoder() {
      if (!(this instanceof Decoder)) return new Decoder();
      (Transform.call(this, { readableObjectMode: !0 }), (this._buffer = Buffer.allocUnsafe(1024)), (this._bufferSize = 0));
    }
    util.inherits(Decoder, Transform);
    Decoder.prototype._transform = function (chunk, encoding, callback) {
      if (this._buffer.length - this._bufferSize < chunk.length) {
        var oldBuffer = this._buffer;
        ((this._buffer = Buffer.allocUnsafe(this._bufferSize + chunk.length)),
          oldBuffer.copy(this._buffer, 0, 0, this._bufferSize));
      }
      for (this._bufferSize += chunk.copy(this._buffer, this._bufferSize); this._bufferSize >= 6; ) {
        var type = this._buffer.readUInt16BE(0),
          size = this._buffer.readUInt32BE(2);
        if (this._bufferSize < 6 + size) break;
        var typeName = nameById[type],
          data = this._buffer.slice(6, 6 + size),
          message;
        if (typeName == 'UDPTunnel') message = Buffer.from(data);
        else
          try {
            message = decode(type, data);
          } catch (e) {
            return callback(e);
          }
        (this._buffer.copy(this._buffer, 0, 6 + size, this._bufferSize),
          (this._bufferSize -= 6 + size),
          this.push({ name: typeName, payload: message }));
      }
      callback();
    };
    module2.exports = { Encoder, Decoder, messages };
  },
});
var require_voice = __commonJS({
  'node_modules/mumble-streams/lib/voice.js'(exports2, module2) {
    'use strict';
    var util = require('util'),
      Transform = require('stream').Transform;
    function Encoder(dest2) {
      if (!(this instanceof Encoder)) return new Encoder(dest2);
      if (dest2 != 'server' && dest2 != 'client') throw new TypeError('dest has to be either "server" or "client"');
      (Transform.call(this, { writableObjectMode: !0 }), (this._dest = dest2));
    }
    util.inherits(Encoder, Transform);
    Encoder.prototype._transform = function (chunk, encoding, callback) {
      var buffer,
        offset = 0;
      if (chunk.timestamp !== void 0)
        return (
          (buffer = Buffer.allocUnsafe(10)),
          (offset += buffer.writeUInt8(32, offset)),
          (offset += toVarint(chunk.timestamp).value.copy(buffer, offset)),
          callback(null, buffer.slice(0, offset))
        );
      var codecId, voiceData;
      if (chunk.codec == 'Opus') {
        if (chunk.frames.length > 1) return callback(new Error('Opus only supports a single frame per packet'));
        var endBit = chunk.end ? 8192 : 0;
        if (chunk.frames.length == 0) voiceData = toVarint(endBit).value;
        else {
          var frameSize = toVarint(chunk.frames[0].length | endBit);
          voiceData = Buffer.concat([frameSize.value, chunk.frames[0]]);
        }
        codecId = 4;
      } else if (['CELT_Alpha', 'CELT_Beta', 'Speex'].indexOf(chunk.codec) >= 0) {
        if (
          ((codecId = { CELT_Alpha: 0, Speex: 2, CELT_Beta: 3 }[chunk.codec]),
          (voiceData = []),
          chunk.frames.length == 0 && !chunk.end)
        )
          return callback(new Error('No frames given but end bit is not set'));
        for (var i = 0; i < chunk.frames.length; i++) {
          var frame = chunk.frames[i];
          if (frame.length > 127) return callback(new Error('Frame size is greater than 127 bytes'));
          (voiceData.push(Buffer.from([frame.length | 128])), voiceData.push(frame));
        }
        (chunk.end && (voiceData.push(Buffer.from([0])), voiceData.push(Buffer.from([]))),
          (voiceData[voiceData.length - 2][0] &= 127),
          (voiceData = Buffer.concat(voiceData)));
      } else return callback(new TypeError('Unknown codec: ' + chunk.codec));
      ((buffer = Buffer.allocUnsafe(19 + voiceData.length + 12)),
        (offset += buffer.writeUInt8((codecId << 5) | chunk.mode, offset)),
        this._dest == 'client' && (offset += toVarint(chunk.source).value.copy(buffer, offset)),
        (offset += toVarint(chunk.seqNum).value.copy(buffer, offset)),
        (offset += voiceData.copy(buffer, offset)),
        chunk.position &&
          ((offset += buffer.writeFloatBE(chunk.position.x, offset)),
          (offset += buffer.writeFloatBE(chunk.position.y, offset)),
          (offset += buffer.writeFloatBE(chunk.position.z, offset))),
        callback(null, buffer.slice(0, offset)));
    };
    function Decoder(orig) {
      if (!(this instanceof Decoder)) return new Decoder(orig);
      if (orig != 'server' && orig != 'client') throw new TypeError('orig has to be either "server" or "client"');
      (Transform.call(this, { readableObjectMode: !0 }), (this._orig = orig));
    }
    util.inherits(Decoder, Transform);
    Decoder.prototype._transform = function (chunk, encoding, callback) {
      var self2 = this,
        reject = function (reason) {
          (self2.emit('debug', 'Failed to parse voice packet', reason, chunk), callback());
        },
        packet = {};
      try {
        if (chunk.length == 0) return reject('empty');
        var codecId = chunk[0] >> 5;
        if (codecId == 1) {
          var val = fromVarint(chunk.slice(1));
          if (!val) return reject('invalid timestamp');
          packet.timestamp = val.value;
        } else {
          var target = chunk[0] & 31;
          packet.target = ['normal', 'shout', 'whisper'][target] || 'loopback';
          var offset = 1;
          if (this._orig == 'server') {
            var source = fromVarint(chunk.slice(offset));
            if (!source) return reject('invalid source');
            ((offset += source.length), (packet.source = source.value));
          }
          var sequenceNumber = fromVarint(chunk.slice(offset));
          if (!sequenceNumber) return reject('invalid sequence number');
          if (((offset += sequenceNumber.length), (packet.seqNum = sequenceNumber.value), codecId == 4)) {
            var voiceLength = fromVarint(chunk.slice(offset));
            if (!voiceLength) return reject('invalid voice length');
            if (
              ((packet.end = (voiceLength.value & 8192) > 0),
              (voiceLength.value &= 8191),
              (offset += voiceLength.length),
              chunk.length < offset + voiceLength.value)
            )
              return reject('not enough voice data');
            var voice = chunk.slice(offset, offset + voiceLength.value);
            ((offset += voiceLength.value), (packet.frames = voice.length ? [voice] : []), (packet.codec = 'Opus'));
          } else if (codecId == 0 || codecIf == 2 || codecId == 3)
            for (packet.codec = ['CELT_Alpha', '', 'Speex', 'CELT_Beta'][codecId], packet.frames = []; ; ) {
              if (chunk.length < offset + 1) return reject('missing frame header');
              var header = chunk[offset++];
              if (header == 0) {
                packet.end = !0;
                break;
              }
              var more = (header & 128) > 0,
                frameLength = header & 127;
              if (chunk.length < offset + frameLength) return reject('not enough voice data');
              if ((packet.frames.push(chunk.slice(offset, (offset += frameLength))), !more)) {
                packet.end = !1;
                break;
              }
            }
          else return (this.emit('unknown_codec', codecId), reject('unknown codec ' + codecId));
          chunk.length > offset + 12 &&
            (packet.position = {
              x: chunk.readFloatBE(offset),
              y: chunk.readFloatBE(offset + 4),
              z: chunk.readFloatBE(offset + 8),
            });
        }
      } catch (e) {
        return callback(e);
      }
      return callback(null, packet);
    };
    module2.exports = { Encoder, Decoder };
    function toVarint(i) {
      var arr = [];
      if (i < 0) {
        if (((i = ~i), i <= 3)) return Buffer.from([252 | i]);
        arr.push(248);
      }
      if (i < 128) arr.push(i);
      else if (i < 16384) (arr.push((i >> 8) | 128), arr.push(i & 255));
      else if (i < 2097152) (arr.push((i >> 16) | 192), arr.push((i >> 8) & 255), arr.push(i & 255));
      else if (i < 268435456)
        (arr.push((i >> 24) | 224), arr.push((i >> 16) & 255), arr.push((i >> 8) & 255), arr.push(i & 255));
      else if (i < 4294967296)
        (arr.push(240),
          arr.push((i >> 24) & 255),
          arr.push((i >> 16) & 255),
          arr.push((i >> 8) & 255),
          arr.push(i & 255));
      else throw new TypeError('Non-integer values are not supported. (' + i + ')');
      return { value: Buffer.from(arr), length: arr.length };
    }
    function fromVarint(b) {
      if (b.length == 0) return null;
      var length = 1,
        i,
        v = b[0];
      if ((v & 128) === 0) i = v & 127;
      else if ((v & 192) === 128) ((i = ((v & 63) << 8) | b[1]), (length = 2));
      else if ((v & 240) === 240)
        switch (v & 252) {
          case 240:
            ((i = (b[1] << 24) | (b[2] << 16) | (b[3] << 8) | b[4]), (length = 5));
            break;
          case 248:
            var ret = fromVarint(b.slice(1));
            return ret && { value: ~ret.value, length: 1 + ret.length };
          case 252:
            ((i = v & 3), (i = ~i));
            break;
          default:
            return null;
        }
      else
        (v & 240) === 224
          ? ((i = ((v & 15) << 24) | (b[1] << 16) | (b[2] << 8) | b[3]), (length = 4))
          : (v & 224) === 192 && ((i = ((v & 31) << 16) | (b[1] << 8) | b[2]), (length = 3));
      return { value: i, length };
    }
  },
});
var require_udp_crypto = __commonJS({
  'node_modules/mumble-streams/lib/udp-crypto.js'(exports2, module2) {
    'use strict';
    var crypto = require('crypto'),
      BLOCK_SIZE = 16;
    function UdpCrypt(stats) {
      ((this._decryptHistory = new Array(100)), (this._stats = stats || {}));
    }
    UdpCrypt.prototype.getKey = function () {
      return this._key;
    };
    UdpCrypt.prototype.getDecryptIV = function () {
      return this._decryptIV;
    };
    UdpCrypt.prototype.getEncryptIV = function () {
      return this._encryptIV;
    };
    UdpCrypt.prototype.ready = function () {
      return this._key && this._decryptIV && this._encryptIV;
    };
    UdpCrypt.prototype.setKey = function (key) {
      if (key.length != BLOCK_SIZE) throw new Error('key must be exactly ' + BLOCK_SIZE + ' bytes');
      this._key = key;
    };
    UdpCrypt.prototype.setDecryptIV = function (decryptIV) {
      if (decryptIV.length != BLOCK_SIZE) throw new Error('decryptIV must be exactly ' + BLOCK_SIZE + ' bytes');
      this._decryptIV = decryptIV;
    };
    UdpCrypt.prototype.setEncryptIV = function (encryptIV) {
      if (encryptIV.length != BLOCK_SIZE) throw new Error('encryptIV must be exactly ' + BLOCK_SIZE + ' bytes');
      this._encryptIV = encryptIV;
    };
    UdpCrypt.prototype.generateKey = function (callback) {
      crypto.randomBytes(
        BLOCK_SIZE * 3,
        function (err, buf) {
          (err && callback(err),
            (this._key = buf.slice(0, BLOCK_SIZE)),
            (this._decryptIV = buf.slice(BLOCK_SIZE, BLOCK_SIZE * 2)),
            (this._encryptIV = buf.slice(BLOCK_SIZE * 2)),
            callback());
        }.bind(this)
      );
    };
    UdpCrypt.prototype.encrypt = function (plainText) {
      for (var i = 0; i < BLOCK_SIZE && ++this._encryptIV[i] == 256; i++) this._encryptIV[i] = 0;
      var cipher = crypto.createCipheriv('AES-128-ECB', this._key, '').setAutoPadding(!1),
        cipherText = Buffer.allocUnsafe(plainText.length + 4),
        tag = ocbEncrypt(plainText, cipherText.slice(4), this._encryptIV, cipher.update.bind(cipher));
      return (
        (cipherText[0] = this._encryptIV[0]),
        (cipherText[1] = tag[0]),
        (cipherText[2] = tag[1]),
        (cipherText[3] = tag[2]),
        cipherText
      );
    };
    UdpCrypt.prototype.decrypt = function (cipherText) {
      if (cipherText.length < 4) return null;
      var saveiv = Buffer.from(this._decryptIV),
        ivbyte = cipherText[0],
        restore = !1,
        lost = 0,
        late = 0,
        i;
      if (((this._decryptIV[0] + 1) & 255) == ivbyte)
        if (ivbyte > this._decryptIV[0]) this._decryptIV[0] = ivbyte;
        else if (ivbyte < this._decryptIV[0])
          for (this._decryptIV[0] = ivbyte, i = 1; i < BLOCK_SIZE && ++this._decryptIV[i] == 256; i++)
            this._encryptIV[i] = 0;
        else return null;
      else {
        var diff = ivbyte - this._decryptIV[0];
        if (
          (diff > 128 ? (diff = diff - 256) : diff < -128 && (diff = diff + 256),
          ivbyte < this._decryptIV[0] && diff > -30 && diff < 0)
        )
          (late++, lost--, (this._decryptIV[0] = ivbyte), (restore = !0));
        else if (ivbyte > this._decryptIV[0] && diff > -30 && diff < 0) {
          for (late++, lost--, this._decryptIV[0] = ivbyte, i = 0; i < BLOCK_SIZE && this._decryptIV[i]-- == -1; i++)
            this._decryptIV[i] = 255;
          restore = !0;
        } else if (ivbyte > this._decryptIV[0] && diff > 0)
          ((lost += ivbyte - this._decryptIV[0] - 1), (this._decryptIV[0] = ivbyte));
        else if (ivbyte < this._decryptIV[0] && diff > 0)
          for (
            lost += 256 - this._decryptIV[0] + ivbyte - 1, this._decryptIV[0] = ivbyte, i = 0;
            i < BLOCK_SIZE && ++this._decryptIV[i] == 256;
            i++
          )
            this._encryptIV[i] = 0;
        else return null;
        if (this._decryptHistory[this._decryptIV[0]] == this._decryptIV[1]) return ((this._decryptIV = saveiv), null);
      }
      var encrypt = crypto.createCipheriv('AES-128-ECB', this._key, '').setAutoPadding(!1),
        decrypt = crypto.createDecipheriv('AES-128-ECB', this._key, '').setAutoPadding(!1),
        plainText = Buffer.allocUnsafe(cipherText.length - 4),
        tag = ocbDecrypt(
          cipherText.slice(4),
          plainText,
          this._decryptIV,
          encrypt.update.bind(encrypt),
          decrypt.update.bind(decrypt)
        );
      return tag.compare(cipherText, 1, 4, 0, 3) !== 0
        ? ((this._decryptIV = saveiv), null)
        : ((this._decryptHistory[this._decryptIV[0]] = this._decryptIV[1]),
          restore && (this._decryptIV = saveiv),
          this._stats.good++,
          (this._stats.late += late),
          (this._stats.lost += lost),
          plainText);
    };
    function ocbEncrypt(plainText, cipherText, nonce, aesEncrypt) {
      var checksum = Buffer.allocUnsafe(BLOCK_SIZE),
        tmp = Buffer.allocUnsafe(BLOCK_SIZE),
        delta = aesEncrypt(nonce);
      ZERO(checksum);
      for (var len = plainText.length; len > BLOCK_SIZE; )
        (S2(delta),
          XOR(tmp, delta, plainText),
          (tmp = aesEncrypt(tmp)),
          XOR(cipherText, delta, tmp),
          XOR(checksum, checksum, plainText),
          (len -= BLOCK_SIZE),
          (plainText = plainText.slice(BLOCK_SIZE)),
          (cipherText = cipherText.slice(BLOCK_SIZE)));
      (S2(delta), ZERO(tmp), (tmp[BLOCK_SIZE - 1] = len * 8), XOR(tmp, tmp, delta));
      var pad = aesEncrypt(tmp);
      (plainText.copy(tmp, 0, 0, len),
        pad.copy(tmp, len, len, BLOCK_SIZE),
        XOR(checksum, checksum, tmp),
        XOR(tmp, pad, tmp),
        tmp.copy(cipherText, 0, 0, len),
        S3(delta),
        XOR(tmp, delta, checksum));
      var tag = aesEncrypt(tmp);
      return tag;
    }
    function ocbDecrypt(cipherText, plainText, nonce, aesEncrypt, aesDecrypt) {
      var checksum = Buffer.allocUnsafe(BLOCK_SIZE),
        tmp = Buffer.allocUnsafe(BLOCK_SIZE),
        delta = aesEncrypt(nonce);
      ZERO(checksum);
      for (var len = plainText.length; len > BLOCK_SIZE; )
        (S2(delta),
          XOR(tmp, delta, cipherText),
          (tmp = aesDecrypt(tmp)),
          XOR(plainText, delta, tmp),
          XOR(checksum, checksum, plainText),
          (len -= BLOCK_SIZE),
          (plainText = plainText.slice(BLOCK_SIZE)),
          (cipherText = cipherText.slice(BLOCK_SIZE)));
      (S2(delta), ZERO(tmp), (tmp[BLOCK_SIZE - 1] = len * 8), XOR(tmp, tmp, delta));
      var pad = aesEncrypt(tmp);
      (ZERO(tmp),
        cipherText.copy(tmp, 0, 0, len),
        XOR(tmp, tmp, pad),
        XOR(checksum, checksum, tmp),
        tmp.copy(plainText, 0, 0, len),
        S3(delta),
        XOR(tmp, delta, checksum));
      var tag = aesEncrypt(tmp);
      return tag;
    }
    function XOR(dst, a, b) {
      for (var i = 0; i < BLOCK_SIZE; i++) dst[i] = a[i] ^ b[i];
    }
    function S2(block) {
      for (var carry = block[0] >> 7, i = 0; i < BLOCK_SIZE - 1; i++) block[i] = (block[i] << 1) | (block[i + 1] >> 7);
      block[BLOCK_SIZE - 1] = (block[BLOCK_SIZE - 1] << 1) ^ (carry * 135);
    }
    function S3(block) {
      for (var carry = block[0] >> 7, i = 0; i < BLOCK_SIZE - 1; i++) block[i] ^= (block[i] << 1) | (block[i + 1] >> 7);
      block[BLOCK_SIZE - 1] ^= (block[BLOCK_SIZE - 1] << 1) ^ (carry * 135);
    }
    function ZERO(block) {
      block.fill(0, 0, BLOCK_SIZE);
    }
    var util = require('util'),
      Transform = require('stream').Transform;
    module2.exports = UdpCrypt;
    module2.exports.BLOCK_SIZE = BLOCK_SIZE;
    module2.exports.ocbEncrypt = ocbEncrypt;
    module2.exports.ocbDecrypt = ocbDecrypt;
    function Encrypt(stats) {
      if (!(this instanceof Encrypt)) return new Encrypt(dest);
      (Transform.call(this, {}), (this._block = new UdpCrypt(stats)));
    }
    util.inherits(Encrypt, Transform);
    Encrypt.prototype._transform = function (chunk, encoding, callback) {
      callback(null, this._block.encrypt(chunk));
    };
    Encrypt.prototype.getBlockCipher = function () {
      return this._block;
    };
  },
});
var require_mumble_streams = __commonJS({
  'node_modules/mumble-streams/index.js'(exports2, module2) {
    'use strict';
    module2.exports.version = {
      major: 1,
      minor: 2,
      patch: 16,
      toUInt8: function () {
        return ((this.major & 65535) << 16) | ((this.minor & 255) << 8) | (this.patch & 255);
      },
    };
    module2.exports.data = require_data();
    module2.exports.voice = require_voice();
    module2.exports.udpCrypto = require_udp_crypto();
  },
});
var require_isarray = __commonJS({
  'node_modules/isarray/index.js'(exports2, module2) {
    'use strict';
    module2.exports =
      Array.isArray ||
      function (arr) {
        return Object.prototype.toString.call(arr) == '[object Array]';
      };
  },
});
var require_util = __commonJS({
  'node_modules/core-util-is/lib/util.js'(exports2) {
    'use strict';
    function isArray(arg) {
      return Array.isArray ? Array.isArray(arg) : objectToString(arg) === '[object Array]';
    }
    exports2.isArray = isArray;
    function isBoolean(arg) {
      return typeof arg == 'boolean';
    }
    exports2.isBoolean = isBoolean;
    function isNull(arg) {
      return arg === null;
    }
    exports2.isNull = isNull;
    function isNullOrUndefined(arg) {
      return arg == null;
    }
    exports2.isNullOrUndefined = isNullOrUndefined;
    function isNumber(arg) {
      return typeof arg == 'number';
    }
    exports2.isNumber = isNumber;
    function isString(arg) {
      return typeof arg == 'string';
    }
    exports2.isString = isString;
    function isSymbol(arg) {
      return typeof arg == 'symbol';
    }
    exports2.isSymbol = isSymbol;
    function isUndefined(arg) {
      return arg === void 0;
    }
    exports2.isUndefined = isUndefined;
    function isRegExp(re) {
      return objectToString(re) === '[object RegExp]';
    }
    exports2.isRegExp = isRegExp;
    function isObject(arg) {
      return typeof arg == 'object' && arg !== null;
    }
    exports2.isObject = isObject;
    function isDate(d) {
      return objectToString(d) === '[object Date]';
    }
    exports2.isDate = isDate;
    function isError(e) {
      return objectToString(e) === '[object Error]' || e instanceof Error;
    }
    exports2.isError = isError;
    function isFunction(arg) {
      return typeof arg == 'function';
    }
    exports2.isFunction = isFunction;
    function isPrimitive(arg) {
      return (
        arg === null ||
        typeof arg == 'boolean' ||
        typeof arg == 'number' ||
        typeof arg == 'string' ||
        typeof arg == 'symbol' ||
        typeof arg > 'u'
      );
    }
    exports2.isPrimitive = isPrimitive;
    exports2.isBuffer = require('buffer').Buffer.isBuffer;
    function objectToString(o) {
      return Object.prototype.toString.call(o);
    }
  },
});
var require_inherits_browser = __commonJS({
  'node_modules/reduplexer/node_modules/inherits/inherits_browser.js'(exports2, module2) {
    'use strict';
    typeof Object.create == 'function'
      ? (module2.exports = function (ctor, superCtor) {
          superCtor &&
            ((ctor.super_ = superCtor),
            (ctor.prototype = Object.create(superCtor.prototype, {
              constructor: { value: ctor, enumerable: !1, writable: !0, configurable: !0 },
            })));
        })
      : (module2.exports = function (ctor, superCtor) {
          if (superCtor) {
            ctor.super_ = superCtor;
            var TempCtor = function () {};
            ((TempCtor.prototype = superCtor.prototype),
              (ctor.prototype = new TempCtor()),
              (ctor.prototype.constructor = ctor));
          }
        });
  },
});
var require_inherits = __commonJS({
  'node_modules/reduplexer/node_modules/inherits/inherits.js'(exports2, module2) {
    'use strict';
    try {
      if (((util = require('util')), typeof util.inherits != 'function')) throw '';
      module2.exports = util.inherits;
    } catch {
      module2.exports = require_inherits_browser();
    }
    var util;
  },
});
var require_string_decoder = __commonJS({
  'node_modules/reduplexer/node_modules/readable-stream/node_modules/string_decoder/index.js'(exports2) {
    'use strict';
    var Buffer2 = require('buffer').Buffer,
      isBufferEncoding =
        Buffer2.isEncoding ||
        function (encoding) {
          switch (encoding && encoding.toLowerCase()) {
            case 'hex':
            case 'utf8':
            case 'utf-8':
            case 'ascii':
            case 'binary':
            case 'base64':
            case 'ucs2':
            case 'ucs-2':
            case 'utf16le':
            case 'utf-16le':
            case 'raw':
              return !0;
            default:
              return !1;
          }
        };
    function assertEncoding(encoding) {
      if (encoding && !isBufferEncoding(encoding)) throw new Error('Unknown encoding: ' + encoding);
    }
    var StringDecoder = (exports2.StringDecoder = function (encoding) {
      switch (
        ((this.encoding = (encoding || 'utf8').toLowerCase().replace(/[-_]/, '')),
        assertEncoding(encoding),
        this.encoding)
      ) {
        case 'utf8':
          this.surrogateSize = 3;
          break;
        case 'ucs2':
        case 'utf16le':
          ((this.surrogateSize = 2), (this.detectIncompleteChar = utf16DetectIncompleteChar));
          break;
        case 'base64':
          ((this.surrogateSize = 3), (this.detectIncompleteChar = base64DetectIncompleteChar));
          break;
        default:
          this.write = passThroughWrite;
          return;
      }
      ((this.charBuffer = Buffer2.allocUnsafe(6)), (this.charReceived = 0), (this.charLength = 0));
    });
    StringDecoder.prototype.write = function (buffer) {
      for (var charStr = ''; this.charLength; ) {
        var available =
          buffer.length >= this.charLength - this.charReceived ? this.charLength - this.charReceived : buffer.length;
        if (
          (buffer.copy(this.charBuffer, this.charReceived, 0, available),
          (this.charReceived += available),
          this.charReceived < this.charLength)
        )
          return '';
        ((buffer = buffer.slice(available, buffer.length)),
          (charStr = this.charBuffer.slice(0, this.charLength).toString(this.encoding)));
        var charCode = charStr.charCodeAt(charStr.length - 1);
        if (charCode >= 55296 && charCode <= 56319) {
          ((this.charLength += this.surrogateSize), (charStr = ''));
          continue;
        }
        if (((this.charReceived = this.charLength = 0), buffer.length === 0)) return charStr;
        break;
      }
      this.detectIncompleteChar(buffer);
      var end = buffer.length;
      (this.charLength &&
        (buffer.copy(this.charBuffer, 0, buffer.length - this.charReceived, end), (end -= this.charReceived)),
        (charStr += buffer.toString(this.encoding, 0, end)));
      var end = charStr.length - 1,
        charCode = charStr.charCodeAt(end);
      if (charCode >= 55296 && charCode <= 56319) {
        var size = this.surrogateSize;
        return (
          (this.charLength += size),
          (this.charReceived += size),
          this.charBuffer.copy(this.charBuffer, size, 0, size),
          buffer.copy(this.charBuffer, 0, 0, size),
          charStr.substring(0, end)
        );
      }
      return charStr;
    };
    StringDecoder.prototype.detectIncompleteChar = function (buffer) {
      for (var i = buffer.length >= 3 ? 3 : buffer.length; i > 0; i--) {
        var c = buffer[buffer.length - i];
        if (i == 1 && c >> 5 == 6) {
          this.charLength = 2;
          break;
        }
        if (i <= 2 && c >> 4 == 14) {
          this.charLength = 3;
          break;
        }
        if (i <= 3 && c >> 3 == 30) {
          this.charLength = 4;
          break;
        }
      }
      this.charReceived = i;
    };
    StringDecoder.prototype.end = function (buffer) {
      var res = '';
      if ((buffer && buffer.length && (res = this.write(buffer)), this.charReceived)) {
        var cr = this.charReceived,
          buf = this.charBuffer,
          enc = this.encoding;
        res += buf.slice(0, cr).toString(enc);
      }
      return res;
    };
    function passThroughWrite(buffer) {
      return buffer.toString(this.encoding);
    }
    function utf16DetectIncompleteChar(buffer) {
      ((this.charReceived = buffer.length % 2), (this.charLength = this.charReceived ? 2 : 0));
    }
    function base64DetectIncompleteChar(buffer) {
      ((this.charReceived = buffer.length % 3), (this.charLength = this.charReceived ? 3 : 0));
    }
  },
});
var require_stream_readable = __commonJS({
  'node_modules/reduplexer/node_modules/readable-stream/lib/_stream_readable.js'(exports2, module2) {
    'use strict';
    module2.exports = Readable;
    var isArray = require_isarray(),
      Buffer2 = require('buffer').Buffer;
    Readable.ReadableState = ReadableState;
    var EE = require('events').EventEmitter;
    EE.listenerCount ||
      (EE.listenerCount = function (emitter, type) {
        return emitter.listeners(type).length;
      });
    var Stream = require('stream'),
      util = require_util();
    util.inherits = require_inherits();
    var StringDecoder;
    util.inherits(Readable, Stream);
    function ReadableState(options, stream) {
      options = options || {};
      var hwm = options.highWaterMark;
      ((this.highWaterMark = hwm || hwm === 0 ? hwm : 16 * 1024),
        (this.highWaterMark = ~~this.highWaterMark),
        (this.buffer = []),
        (this.length = 0),
        (this.pipes = null),
        (this.pipesCount = 0),
        (this.flowing = !1),
        (this.ended = !1),
        (this.endEmitted = !1),
        (this.reading = !1),
        (this.calledRead = !1),
        (this.sync = !0),
        (this.needReadable = !1),
        (this.emittedReadable = !1),
        (this.readableListening = !1),
        (this.objectMode = !!options.objectMode),
        (this.defaultEncoding = options.defaultEncoding || 'utf8'),
        (this.ranOut = !1),
        (this.awaitDrain = 0),
        (this.readingMore = !1),
        (this.decoder = null),
        (this.encoding = null),
        options.encoding &&
          (StringDecoder || (StringDecoder = require_string_decoder().StringDecoder),
          (this.decoder = new StringDecoder(options.encoding)),
          (this.encoding = options.encoding)));
    }
    function Readable(options) {
      if (!(this instanceof Readable)) return new Readable(options);
      ((this._readableState = new ReadableState(options, this)), (this.readable = !0), Stream.call(this));
    }
    Readable.prototype.push = function (chunk, encoding) {
      var state = this._readableState;
      return (
        typeof chunk == 'string' &&
          !state.objectMode &&
          ((encoding = encoding || state.defaultEncoding),
          encoding !== state.encoding && ((chunk = Buffer2.from(chunk, encoding)), (encoding = ''))),
        readableAddChunk(this, state, chunk, encoding, !1)
      );
    };
    Readable.prototype.unshift = function (chunk) {
      var state = this._readableState;
      return readableAddChunk(this, state, chunk, '', !0);
    };
    function readableAddChunk(stream, state, chunk, encoding, addToFront) {
      var er = chunkInvalid(state, chunk);
      if (er) stream.emit('error', er);
      else if (chunk == null) ((state.reading = !1), state.ended || onEofChunk(stream, state));
      else if (state.objectMode || (chunk && chunk.length > 0))
        if (state.ended && !addToFront) {
          var e = new Error('stream.push() after EOF');
          stream.emit('error', e);
        } else if (state.endEmitted && addToFront) {
          var e = new Error('stream.unshift() after end event');
          stream.emit('error', e);
        } else
          (state.decoder && !addToFront && !encoding && (chunk = state.decoder.write(chunk)),
            (state.length += state.objectMode ? 1 : chunk.length),
            addToFront ? state.buffer.unshift(chunk) : ((state.reading = !1), state.buffer.push(chunk)),
            state.needReadable && emitReadable(stream),
            maybeReadMore(stream, state));
      else addToFront || (state.reading = !1);
      return needMoreData(state);
    }
    function needMoreData(state) {
      return !state.ended && (state.needReadable || state.length < state.highWaterMark || state.length === 0);
    }
    Readable.prototype.setEncoding = function (enc) {
      (StringDecoder || (StringDecoder = require_string_decoder().StringDecoder),
        (this._readableState.decoder = new StringDecoder(enc)),
        (this._readableState.encoding = enc));
    };
    var MAX_HWM = 8388608;
    function roundUpToNextPowerOf2(n) {
      if (n >= MAX_HWM) n = MAX_HWM;
      else {
        n--;
        for (var p = 1; p < 32; p <<= 1) n |= n >> p;
        n++;
      }
      return n;
    }
    function howMuchToRead(n, state) {
      return state.length === 0 && state.ended
        ? 0
        : state.objectMode
          ? n === 0
            ? 0
            : 1
          : n === null || isNaN(n)
            ? state.flowing && state.buffer.length
              ? state.buffer[0].length
              : state.length
            : n <= 0
              ? 0
              : (n > state.highWaterMark && (state.highWaterMark = roundUpToNextPowerOf2(n)),
                n > state.length ? (state.ended ? state.length : ((state.needReadable = !0), 0)) : n);
    }
    Readable.prototype.read = function (n) {
      var state = this._readableState;
      state.calledRead = !0;
      var nOrig = n,
        ret;
      if (
        ((typeof n != 'number' || n > 0) && (state.emittedReadable = !1),
        n === 0 && state.needReadable && (state.length >= state.highWaterMark || state.ended))
      )
        return (emitReadable(this), null);
      if (((n = howMuchToRead(n, state)), n === 0 && state.ended))
        return (
          (ret = null),
          state.length > 0 && state.decoder && ((ret = fromList(n, state)), (state.length -= ret.length)),
          state.length === 0 && endReadable(this),
          ret
        );
      var doRead = state.needReadable;
      return (
        state.length - n <= state.highWaterMark && (doRead = !0),
        (state.ended || state.reading) && (doRead = !1),
        doRead &&
          ((state.reading = !0),
          (state.sync = !0),
          state.length === 0 && (state.needReadable = !0),
          this._read(state.highWaterMark),
          (state.sync = !1)),
        doRead && !state.reading && (n = howMuchToRead(nOrig, state)),
        n > 0 ? (ret = fromList(n, state)) : (ret = null),
        ret === null && ((state.needReadable = !0), (n = 0)),
        (state.length -= n),
        state.length === 0 && !state.ended && (state.needReadable = !0),
        state.ended && !state.endEmitted && state.length === 0 && endReadable(this),
        ret
      );
    };
    function chunkInvalid(state, chunk) {
      var er = null;
      return (
        !Buffer2.isBuffer(chunk) &&
          typeof chunk != 'string' &&
          chunk !== null &&
          chunk !== void 0 &&
          !state.objectMode &&
          (er = new TypeError('Invalid non-string/buffer chunk')),
        er
      );
    }
    function onEofChunk(stream, state) {
      if (state.decoder && !state.ended) {
        var chunk = state.decoder.end();
        chunk && chunk.length && (state.buffer.push(chunk), (state.length += state.objectMode ? 1 : chunk.length));
      }
      ((state.ended = !0), state.length > 0 ? emitReadable(stream) : endReadable(stream));
    }
    function emitReadable(stream) {
      var state = stream._readableState;
      ((state.needReadable = !1),
        !state.emittedReadable &&
          ((state.emittedReadable = !0),
          state.sync
            ? process.nextTick(function () {
                emitReadable_(stream);
              })
            : emitReadable_(stream)));
    }
    function emitReadable_(stream) {
      stream.emit('readable');
    }
    function maybeReadMore(stream, state) {
      state.readingMore ||
        ((state.readingMore = !0),
        process.nextTick(function () {
          maybeReadMore_(stream, state);
        }));
    }
    function maybeReadMore_(stream, state) {
      for (
        var len = state.length;
        !state.reading &&
        !state.flowing &&
        !state.ended &&
        state.length < state.highWaterMark &&
        (stream.read(0), len !== state.length);
      )
        len = state.length;
      state.readingMore = !1;
    }
    Readable.prototype._read = function (n) {
      this.emit('error', new Error('not implemented'));
    };
    Readable.prototype.pipe = function (dest2, pipeOpts) {
      var src = this,
        state = this._readableState;
      switch (state.pipesCount) {
        case 0:
          state.pipes = dest2;
          break;
        case 1:
          state.pipes = [state.pipes, dest2];
          break;
        default:
          state.pipes.push(dest2);
          break;
      }
      state.pipesCount += 1;
      var doEnd = (!pipeOpts || pipeOpts.end !== !1) && dest2 !== process.stdout && dest2 !== process.stderr,
        endFn = doEnd ? onend : cleanup;
      (state.endEmitted ? process.nextTick(endFn) : src.once('end', endFn), dest2.on('unpipe', onunpipe));
      function onunpipe(readable) {
        readable === src && cleanup();
      }
      function onend() {
        dest2.end();
      }
      var ondrain = pipeOnDrain(src);
      dest2.on('drain', ondrain);
      function cleanup() {
        (dest2.removeListener('close', onclose),
          dest2.removeListener('finish', onfinish),
          dest2.removeListener('drain', ondrain),
          dest2.removeListener('error', onerror),
          dest2.removeListener('unpipe', onunpipe),
          src.removeListener('end', onend),
          src.removeListener('end', cleanup),
          (!dest2._writableState || dest2._writableState.needDrain) && ondrain());
      }
      function onerror(er) {
        (unpipe(),
          dest2.removeListener('error', onerror),
          EE.listenerCount(dest2, 'error') === 0 && dest2.emit('error', er));
      }
      !dest2._events || !dest2._events.error
        ? dest2.on('error', onerror)
        : isArray(dest2._events.error)
          ? dest2._events.error.unshift(onerror)
          : (dest2._events.error = [onerror, dest2._events.error]);
      function onclose() {
        (dest2.removeListener('finish', onfinish), unpipe());
      }
      dest2.once('close', onclose);
      function onfinish() {
        (dest2.removeListener('close', onclose), unpipe());
      }
      dest2.once('finish', onfinish);
      function unpipe() {
        src.unpipe(dest2);
      }
      return (
        dest2.emit('pipe', src),
        state.flowing ||
          (this.on('readable', pipeOnReadable),
          (state.flowing = !0),
          process.nextTick(function () {
            flow(src);
          })),
        dest2
      );
    };
    function pipeOnDrain(src) {
      return function () {
        var dest2 = this,
          state = src._readableState;
        (state.awaitDrain--, state.awaitDrain === 0 && flow(src));
      };
    }
    function flow(src) {
      var state = src._readableState,
        chunk;
      state.awaitDrain = 0;
      function write(dest2, i, list) {
        var written = dest2.write(chunk);
        written === !1 && state.awaitDrain++;
      }
      for (; state.pipesCount && (chunk = src.read()) !== null; )
        if (
          (state.pipesCount === 1 ? write(state.pipes, 0, null) : forEach(state.pipes, write),
          src.emit('data', chunk),
          state.awaitDrain > 0)
        )
          return;
      if (state.pipesCount === 0) {
        ((state.flowing = !1), EE.listenerCount(src, 'data') > 0 && emitDataEvents(src));
        return;
      }
      state.ranOut = !0;
    }
    function pipeOnReadable() {
      this._readableState.ranOut && ((this._readableState.ranOut = !1), flow(this));
    }
    Readable.prototype.unpipe = function (dest2) {
      var state = this._readableState;
      if (state.pipesCount === 0) return this;
      if (state.pipesCount === 1)
        return dest2 && dest2 !== state.pipes
          ? this
          : (dest2 || (dest2 = state.pipes),
            (state.pipes = null),
            (state.pipesCount = 0),
            this.removeListener('readable', pipeOnReadable),
            (state.flowing = !1),
            dest2 && dest2.emit('unpipe', this),
            this);
      if (!dest2) {
        var dests = state.pipes,
          len = state.pipesCount;
        ((state.pipes = null),
          (state.pipesCount = 0),
          this.removeListener('readable', pipeOnReadable),
          (state.flowing = !1));
        for (var i = 0; i < len; i++) dests[i].emit('unpipe', this);
        return this;
      }
      var i = indexOf(state.pipes, dest2);
      return i === -1
        ? this
        : (state.pipes.splice(i, 1),
          (state.pipesCount -= 1),
          state.pipesCount === 1 && (state.pipes = state.pipes[0]),
          dest2.emit('unpipe', this),
          this);
    };
    Readable.prototype.on = function (ev, fn) {
      var res = Stream.prototype.on.call(this, ev, fn);
      if ((ev === 'data' && !this._readableState.flowing && emitDataEvents(this), ev === 'readable' && this.readable)) {
        var state = this._readableState;
        state.readableListening ||
          ((state.readableListening = !0),
          (state.emittedReadable = !1),
          (state.needReadable = !0),
          state.reading ? state.length && emitReadable(this, state) : this.read(0));
      }
      return res;
    };
    Readable.prototype.addListener = Readable.prototype.on;
    Readable.prototype.resume = function () {
      (emitDataEvents(this), this.read(0), this.emit('resume'));
    };
    Readable.prototype.pause = function () {
      (emitDataEvents(this, !0), this.emit('pause'));
    };
    function emitDataEvents(stream, startPaused) {
      var state = stream._readableState;
      if (state.flowing) throw new Error('Cannot switch to old mode now.');
      var paused = startPaused || !1,
        readable = !1;
      ((stream.readable = !0),
        (stream.pipe = Stream.prototype.pipe),
        (stream.on = stream.addListener = Stream.prototype.on),
        stream.on('readable', function () {
          readable = !0;
          for (var c; !paused && (c = stream.read()) !== null; ) stream.emit('data', c);
          c === null && ((readable = !1), (stream._readableState.needReadable = !0));
        }),
        (stream.pause = function () {
          ((paused = !0), this.emit('pause'));
        }),
        (stream.resume = function () {
          ((paused = !1),
            readable
              ? process.nextTick(function () {
                  stream.emit('readable');
                })
              : this.read(0),
            this.emit('resume'));
        }),
        stream.emit('readable'));
    }
    Readable.prototype.wrap = function (stream) {
      var state = this._readableState,
        paused = !1,
        self2 = this;
      (stream.on('end', function () {
        if (state.decoder && !state.ended) {
          var chunk = state.decoder.end();
          chunk && chunk.length && self2.push(chunk);
        }
        self2.push(null);
      }),
        stream.on('data', function (chunk) {
          if (
            (state.decoder && (chunk = state.decoder.write(chunk)),
            !(state.objectMode && chunk == null) && !(!state.objectMode && (!chunk || !chunk.length)))
          ) {
            var ret = self2.push(chunk);
            ret || ((paused = !0), stream.pause());
          }
        }));
      for (var i in stream)
        typeof stream[i] == 'function' &&
          typeof this[i] > 'u' &&
          (this[i] = (function (method) {
            return function () {
              return stream[method].apply(stream, arguments);
            };
          })(i));
      var events = ['error', 'close', 'destroy', 'pause', 'resume'];
      return (
        forEach(events, function (ev) {
          stream.on(ev, self2.emit.bind(self2, ev));
        }),
        (self2._read = function (n) {
          paused && ((paused = !1), stream.resume());
        }),
        self2
      );
    };
    Readable._fromList = fromList;
    function fromList(n, state) {
      var list = state.buffer,
        length = state.length,
        stringMode = !!state.decoder,
        objectMode = !!state.objectMode,
        ret;
      if (list.length === 0) return null;
      if (length === 0) ret = null;
      else if (objectMode) ret = list.shift();
      else if (!n || n >= length)
        (stringMode ? (ret = list.join('')) : (ret = Buffer2.concat(list, length)), (list.length = 0));
      else if (n < list[0].length) {
        var buf = list[0];
        ((ret = buf.slice(0, n)), (list[0] = buf.slice(n)));
      } else if (n === list[0].length) ret = list.shift();
      else {
        stringMode ? (ret = '') : (ret = Buffer2.allocUnsafe(n));
        for (var c = 0, i = 0, l = list.length; i < l && c < n; i++) {
          var buf = list[0],
            cpy = Math.min(n - c, buf.length);
          (stringMode ? (ret += buf.slice(0, cpy)) : buf.copy(ret, c, 0, cpy),
            cpy < buf.length ? (list[0] = buf.slice(cpy)) : list.shift(),
            (c += cpy));
        }
      }
      return ret;
    }
    function endReadable(stream) {
      var state = stream._readableState;
      if (state.length > 0) throw new Error('endReadable called on non-empty stream');
      !state.endEmitted &&
        state.calledRead &&
        ((state.ended = !0),
        process.nextTick(function () {
          !state.endEmitted &&
            state.length === 0 &&
            ((state.endEmitted = !0), (stream.readable = !1), stream.emit('end'));
        }));
    }
    function forEach(xs, f) {
      for (var i = 0, l = xs.length; i < l; i++) f(xs[i], i);
    }
    function indexOf(xs, x) {
      for (var i = 0, l = xs.length; i < l; i++) if (xs[i] === x) return i;
      return -1;
    }
  },
});
var require_stream_duplex = __commonJS({
  'node_modules/reduplexer/node_modules/readable-stream/lib/_stream_duplex.js'(exports2, module2) {
    'use strict';
    module2.exports = Duplex;
    var objectKeys =
        Object.keys ||
        function (obj) {
          var keys = [];
          for (var key in obj) keys.push(key);
          return keys;
        },
      util = require_util();
    util.inherits = require_inherits();
    var Readable = require_stream_readable(),
      Writable = require_stream_writable();
    util.inherits(Duplex, Readable);
    forEach(objectKeys(Writable.prototype), function (method) {
      Duplex.prototype[method] || (Duplex.prototype[method] = Writable.prototype[method]);
    });
    function Duplex(options) {
      if (!(this instanceof Duplex)) return new Duplex(options);
      (Readable.call(this, options),
        Writable.call(this, options),
        options && options.readable === !1 && (this.readable = !1),
        options && options.writable === !1 && (this.writable = !1),
        (this.allowHalfOpen = !0),
        options && options.allowHalfOpen === !1 && (this.allowHalfOpen = !1),
        this.once('end', onend));
    }
    function onend() {
      this.allowHalfOpen || this._writableState.ended || process.nextTick(this.end.bind(this));
    }
    function forEach(xs, f) {
      for (var i = 0, l = xs.length; i < l; i++) f(xs[i], i);
    }
  },
});
var require_stream_writable = __commonJS({
  'node_modules/reduplexer/node_modules/readable-stream/lib/_stream_writable.js'(exports2, module2) {
    'use strict';
    module2.exports = Writable;
    var Buffer2 = require('buffer').Buffer;
    Writable.WritableState = WritableState;
    var util = require_util();
    util.inherits = require_inherits();
    var Stream = require('stream');
    util.inherits(Writable, Stream);
    function WriteReq(chunk, encoding, cb) {
      ((this.chunk = chunk), (this.encoding = encoding), (this.callback = cb));
    }
    function WritableState(options, stream) {
      options = options || {};
      var hwm = options.highWaterMark;
      ((this.highWaterMark = hwm || hwm === 0 ? hwm : 16 * 1024),
        (this.objectMode = !!options.objectMode),
        (this.highWaterMark = ~~this.highWaterMark),
        (this.needDrain = !1),
        (this.ending = !1),
        (this.ended = !1),
        (this.finished = !1));
      var noDecode = options.decodeStrings === !1;
      ((this.decodeStrings = !noDecode),
        (this.defaultEncoding = options.defaultEncoding || 'utf8'),
        (this.length = 0),
        (this.writing = !1),
        (this.sync = !0),
        (this.bufferProcessing = !1),
        (this.onwrite = function (er) {
          onwrite(stream, er);
        }),
        (this.writecb = null),
        (this.writelen = 0),
        (this.buffer = []),
        (this.errorEmitted = !1));
    }
    function Writable(options) {
      var Duplex = require_stream_duplex();
      if (!(this instanceof Writable) && !(this instanceof Duplex)) return new Writable(options);
      ((this._writableState = new WritableState(options, this)), (this.writable = !0), Stream.call(this));
    }
    Writable.prototype.pipe = function () {
      this.emit('error', new Error('Cannot pipe. Not readable.'));
    };
    function writeAfterEnd(stream, state, cb) {
      var er = new Error('write after end');
      (stream.emit('error', er),
        process.nextTick(function () {
          cb(er);
        }));
    }
    function validChunk(stream, state, chunk, cb) {
      var valid = !0;
      if (
        !Buffer2.isBuffer(chunk) &&
        typeof chunk != 'string' &&
        chunk !== null &&
        chunk !== void 0 &&
        !state.objectMode
      ) {
        var er = new TypeError('Invalid non-string/buffer chunk');
        (stream.emit('error', er),
          process.nextTick(function () {
            cb(er);
          }),
          (valid = !1));
      }
      return valid;
    }
    Writable.prototype.write = function (chunk, encoding, cb) {
      var state = this._writableState,
        ret = !1;
      return (
        typeof encoding == 'function' && ((cb = encoding), (encoding = null)),
        Buffer2.isBuffer(chunk) ? (encoding = 'buffer') : encoding || (encoding = state.defaultEncoding),
        typeof cb != 'function' && (cb = function () {}),
        state.ended
          ? writeAfterEnd(this, state, cb)
          : validChunk(this, state, chunk, cb) && (ret = writeOrBuffer(this, state, chunk, encoding, cb)),
        ret
      );
    };
    function decodeChunk(state, chunk, encoding) {
      return (
        !state.objectMode &&
          state.decodeStrings !== !1 &&
          typeof chunk == 'string' &&
          (chunk = Buffer2.from(chunk, encoding)),
        chunk
      );
    }
    function writeOrBuffer(stream, state, chunk, encoding, cb) {
      ((chunk = decodeChunk(state, chunk, encoding)), Buffer2.isBuffer(chunk) && (encoding = 'buffer'));
      var len = state.objectMode ? 1 : chunk.length;
      state.length += len;
      var ret = state.length < state.highWaterMark;
      return (
        ret || (state.needDrain = !0),
        state.writing
          ? state.buffer.push(new WriteReq(chunk, encoding, cb))
          : doWrite(stream, state, len, chunk, encoding, cb),
        ret
      );
    }
    function doWrite(stream, state, len, chunk, encoding, cb) {
      ((state.writelen = len),
        (state.writecb = cb),
        (state.writing = !0),
        (state.sync = !0),
        stream._write(chunk, encoding, state.onwrite),
        (state.sync = !1));
    }
    function onwriteError(stream, state, sync, er, cb) {
      (sync
        ? process.nextTick(function () {
            cb(er);
          })
        : cb(er),
        (stream._writableState.errorEmitted = !0),
        stream.emit('error', er));
    }
    function onwriteStateUpdate(state) {
      ((state.writing = !1), (state.writecb = null), (state.length -= state.writelen), (state.writelen = 0));
    }
    function onwrite(stream, er) {
      var state = stream._writableState,
        sync = state.sync,
        cb = state.writecb;
      if ((onwriteStateUpdate(state), er)) onwriteError(stream, state, sync, er, cb);
      else {
        var finished = needFinish(stream, state);
        (!finished && !state.bufferProcessing && state.buffer.length && clearBuffer(stream, state),
          sync
            ? process.nextTick(function () {
                afterWrite(stream, state, finished, cb);
              })
            : afterWrite(stream, state, finished, cb));
      }
    }
    function afterWrite(stream, state, finished, cb) {
      (finished || onwriteDrain(stream, state), cb(), finished && finishMaybe(stream, state));
    }
    function onwriteDrain(stream, state) {
      state.length === 0 && state.needDrain && ((state.needDrain = !1), stream.emit('drain'));
    }
    function clearBuffer(stream, state) {
      state.bufferProcessing = !0;
      for (var c = 0; c < state.buffer.length; c++) {
        var entry = state.buffer[c],
          chunk = entry.chunk,
          encoding = entry.encoding,
          cb = entry.callback,
          len = state.objectMode ? 1 : chunk.length;
        if ((doWrite(stream, state, len, chunk, encoding, cb), state.writing)) {
          c++;
          break;
        }
      }
      ((state.bufferProcessing = !1),
        c < state.buffer.length ? (state.buffer = state.buffer.slice(c)) : (state.buffer.length = 0));
    }
    Writable.prototype._write = function (chunk, encoding, cb) {
      cb(new Error('not implemented'));
    };
    Writable.prototype.end = function (chunk, encoding, cb) {
      var state = this._writableState;
      (typeof chunk == 'function'
        ? ((cb = chunk), (chunk = null), (encoding = null))
        : typeof encoding == 'function' && ((cb = encoding), (encoding = null)),
        typeof chunk < 'u' && chunk !== null && this.write(chunk, encoding),
        !state.ending && !state.finished && endWritable(this, state, cb));
    };
    function needFinish(stream, state) {
      return state.ending && state.length === 0 && !state.finished && !state.writing;
    }
    function finishMaybe(stream, state) {
      var need = needFinish(stream, state);
      return (need && ((state.finished = !0), stream.emit('finish')), need);
    }
    function endWritable(stream, state, cb) {
      ((state.ending = !0),
        finishMaybe(stream, state),
        cb && (state.finished ? process.nextTick(cb) : stream.once('finish', cb)),
        (state.ended = !0));
    }
  },
});
var require_stream_transform = __commonJS({
  'node_modules/reduplexer/node_modules/readable-stream/lib/_stream_transform.js'(exports2, module2) {
    'use strict';
    module2.exports = Transform;
    var Duplex = require_stream_duplex(),
      util = require_util();
    util.inherits = require_inherits();
    util.inherits(Transform, Duplex);
    function TransformState(options, stream) {
      ((this.afterTransform = function (er, data) {
        return afterTransform(stream, er, data);
      }),
        (this.needTransform = !1),
        (this.transforming = !1),
        (this.writecb = null),
        (this.writechunk = null));
    }
    function afterTransform(stream, er, data) {
      var ts = stream._transformState;
      ts.transforming = !1;
      var cb = ts.writecb;
      if (!cb) return stream.emit('error', new Error('no writecb in Transform class'));
      ((ts.writechunk = null), (ts.writecb = null), data != null && stream.push(data), cb && cb(er));
      var rs = stream._readableState;
      ((rs.reading = !1), (rs.needReadable || rs.length < rs.highWaterMark) && stream._read(rs.highWaterMark));
    }
    function Transform(options) {
      if (!(this instanceof Transform)) return new Transform(options);
      Duplex.call(this, options);
      var ts = (this._transformState = new TransformState(options, this)),
        stream = this;
      ((this._readableState.needReadable = !0),
        (this._readableState.sync = !1),
        this.once('finish', function () {
          typeof this._flush == 'function'
            ? this._flush(function (er) {
                done(stream, er);
              })
            : done(stream);
        }));
    }
    Transform.prototype.push = function (chunk, encoding) {
      return ((this._transformState.needTransform = !1), Duplex.prototype.push.call(this, chunk, encoding));
    };
    Transform.prototype._transform = function (chunk, encoding, cb) {
      throw new Error('not implemented');
    };
    Transform.prototype._write = function (chunk, encoding, cb) {
      var ts = this._transformState;
      if (((ts.writecb = cb), (ts.writechunk = chunk), (ts.writeencoding = encoding), !ts.transforming)) {
        var rs = this._readableState;
        (ts.needTransform || rs.needReadable || rs.length < rs.highWaterMark) && this._read(rs.highWaterMark);
      }
    };
    Transform.prototype._read = function (n) {
      var ts = this._transformState;
      ts.writechunk !== null && ts.writecb && !ts.transforming
        ? ((ts.transforming = !0), this._transform(ts.writechunk, ts.writeencoding, ts.afterTransform))
        : (ts.needTransform = !0);
    };
    function done(stream, er) {
      if (er) return stream.emit('error', er);
      var ws = stream._writableState,
        rs = stream._readableState,
        ts = stream._transformState;
      if (ws.length) throw new Error('calling transform done when ws.length != 0');
      if (ts.transforming) throw new Error('calling transform done when still transforming');
      return stream.push(null);
    }
  },
});
var require_stream_passthrough = __commonJS({
  'node_modules/reduplexer/node_modules/readable-stream/lib/_stream_passthrough.js'(exports2, module2) {
    'use strict';
    module2.exports = PassThrough;
    var Transform = require_stream_transform(),
      util = require_util();
    util.inherits = require_inherits();
    util.inherits(PassThrough, Transform);
    function PassThrough(options) {
      if (!(this instanceof PassThrough)) return new PassThrough(options);
      Transform.call(this, options);
    }
    PassThrough.prototype._transform = function (chunk, encoding, cb) {
      cb(null, chunk);
    };
  },
});
var require_readable = __commonJS({
  'node_modules/reduplexer/node_modules/readable-stream/readable.js'(exports2, module2) {
    'use strict';
    var Stream = require('stream');
    exports2 = module2.exports = require_stream_readable();
    exports2.Stream = Stream;
    exports2.Readable = exports2;
    exports2.Writable = require_stream_writable();
    exports2.Duplex = require_stream_duplex();
    exports2.Transform = require_stream_transform();
    exports2.PassThrough = require_stream_passthrough();
    !process.browser && process.env.READABLE_STREAM === 'disable' && (module2.exports = require('stream'));
  },
});
var require_reduplexer = __commonJS({
  'node_modules/reduplexer/index.js'(exports2, module2) {
    'use strict';
    var Duplex = require_readable().Duplex,
      Writable = require_readable().Writable,
      inherits = require_inherits();
    function ReaDuplexer(writable, readable, options) {
      if (!(this instanceof ReaDuplexer)) return new ReaDuplexer(writable, readable, options);
      ((this._options = options),
        Duplex.call(this, options),
        this.hook(writable, readable),
        this.on('finish', function () {
          this._writable && this._writable.end();
        }),
        (this._lastReadCallback = null));
    }
    inherits(ReaDuplexer, Duplex);
    function callWrite2Args(chunk, enc, cb) {
      return (this._writable.write(chunk, enc), cb(), !0);
    }
    function callWrite3Args(chunk, enc, cb) {
      return this._writable.write(chunk, enc, cb);
    }
    ReaDuplexer.prototype.hookWritable = function (writable) {
      var that = this;
      if (this._writable) throw new Error('already hooked to a Writable');
      if (!writable) throw new Error('missing writable');
      return (
        (this._writable = writable),
        writable.on('drain', function () {
          that.emit('drain');
        }),
        writable.on('error', function (err) {
          that.emit('error', err);
        }),
        this._writable.write.length === 3 ? (this._callWrite = callWrite3Args) : (this._callWrite = callWrite2Args),
        this._firstPayload &&
          (this._callWrite(this._firstPayload.chunk, this._firstPayload.enc, this._firstPayload.cb),
          delete this._firstPayload),
        this
      );
    };
    ReaDuplexer.prototype.hookReadable = function (readable) {
      var that = this,
        dummyWritable = new Writable(this._options);
      if (this._readable) throw new Error('already hooked to a Readable');
      if (!readable) throw new Error('missing readable');
      return (
        (this._readable = readable),
        (dummyWritable._write = function (chunk, enc, cb) {
          that.push(chunk, enc) ? cb() : (that._lastReadCallback = cb);
        }),
        dummyWritable.on('finish', function () {
          that.push(null);
        }),
        [readable, dummyWritable].forEach(function (stream) {
          stream.on('error', function (err) {
            that.emit('error', err);
          });
        }),
        readable.pipe(dummyWritable),
        this
      );
    };
    ReaDuplexer.prototype.hook = function (writable, readable) {
      return (writable && this.hookWritable(writable), readable && this.hookReadable(readable), this);
    };
    ReaDuplexer.prototype._read = function (n) {
      (this._lastReadCallback && this._lastReadCallback(), (this._lastReadCallback = null));
    };
    ReaDuplexer.prototype._callWrite = function () {
      throw new Error('hook Writable to use');
    };
    ReaDuplexer.prototype._write = function (chunk, enc, cb) {
      if (this._writable) return this._callWrite(chunk, enc, cb);
      this._firstPayload = { chunk, enc, cb };
    };
    module2.exports = ReaDuplexer;
  },
});
var require_process_nextick_args = __commonJS({
  'node_modules/process-nextick-args/index.js'(exports2, module2) {
    'use strict';
    typeof process > 'u' ||
    !process.version ||
    process.version.indexOf('v0.') === 0 ||
    (process.version.indexOf('v1.') === 0 && process.version.indexOf('v1.8.') !== 0)
      ? (module2.exports = { nextTick })
      : (module2.exports = process);
    function nextTick(fn, arg1, arg2, arg3) {
      if (typeof fn != 'function') throw new TypeError('"callback" argument must be a function');
      var len = arguments.length,
        args,
        i;
      switch (len) {
        case 0:
        case 1:
          return process.nextTick(fn);
        case 2:
          return process.nextTick(function () {
            fn.call(null, arg1);
          });
        case 3:
          return process.nextTick(function () {
            fn.call(null, arg1, arg2);
          });
        case 4:
          return process.nextTick(function () {
            fn.call(null, arg1, arg2, arg3);
          });
        default:
          for (args = new Array(len - 1), i = 0; i < args.length; ) args[i++] = arguments[i];
          return process.nextTick(function () {
            fn.apply(null, args);
          });
      }
    }
  },
});
var require_isarray2 = __commonJS({
  'node_modules/through2/node_modules/readable-stream/node_modules/isarray/index.js'(exports2, module2) {
    'use strict';
    var toString = {}.toString;
    module2.exports =
      Array.isArray ||
      function (arr) {
        return toString.call(arr) == '[object Array]';
      };
  },
});
var require_stream = __commonJS({
  'node_modules/through2/node_modules/readable-stream/lib/internal/streams/stream.js'(exports2, module2) {
    'use strict';
    module2.exports = require('stream');
  },
});
var require_safe_buffer = __commonJS({
  'node_modules/through2/node_modules/readable-stream/node_modules/safe-buffer/index.js'(exports2, module2) {
    'use strict';
    var buffer = require('buffer'),
      Buffer2 = buffer.Buffer;
    function copyProps(src, dst) {
      for (var key in src) dst[key] = src[key];
    }
    Buffer2.from && Buffer2.alloc && Buffer2.allocUnsafe && Buffer2.allocUnsafeSlow
      ? (module2.exports = buffer)
      : (copyProps(buffer, exports2), (exports2.Buffer = SafeBuffer));
    function SafeBuffer(arg, encodingOrOffset, length) {
      return Buffer2(arg, encodingOrOffset, length);
    }
    copyProps(Buffer2, SafeBuffer);
    SafeBuffer.from = function (arg, encodingOrOffset, length) {
      if (typeof arg == 'number') throw new TypeError('Argument must not be a number');
      return Buffer2(arg, encodingOrOffset, length);
    };
    SafeBuffer.alloc = function (size, fill, encoding) {
      if (typeof size != 'number') throw new TypeError('Argument must be a number');
      var buf = Buffer2(size);
      return (
        fill !== void 0 ? (typeof encoding == 'string' ? buf.fill(fill, encoding) : buf.fill(fill)) : buf.fill(0),
        buf
      );
    };
    SafeBuffer.allocUnsafe = function (size) {
      if (typeof size != 'number') throw new TypeError('Argument must be a number');
      return Buffer2(size);
    };
    SafeBuffer.allocUnsafeSlow = function (size) {
      if (typeof size != 'number') throw new TypeError('Argument must be a number');
      return Buffer.allocUnsafeSlow(size);
    };
  },
});
var require_inherits_browser2 = __commonJS({
  'node_modules/through2/node_modules/readable-stream/node_modules/inherits/inherits_browser.js'(exports2, module2) {
    'use strict';
    typeof Object.create == 'function'
      ? (module2.exports = function (ctor, superCtor) {
          superCtor &&
            ((ctor.super_ = superCtor),
            (ctor.prototype = Object.create(superCtor.prototype, {
              constructor: { value: ctor, enumerable: !1, writable: !0, configurable: !0 },
            })));
        })
      : (module2.exports = function (ctor, superCtor) {
          if (superCtor) {
            ctor.super_ = superCtor;
            var TempCtor = function () {};
            ((TempCtor.prototype = superCtor.prototype),
              (ctor.prototype = new TempCtor()),
              (ctor.prototype.constructor = ctor));
          }
        });
  },
});
var require_inherits2 = __commonJS({
  'node_modules/through2/node_modules/readable-stream/node_modules/inherits/inherits.js'(exports2, module2) {
    'use strict';
    try {
      if (((util = require('util')), typeof util.inherits != 'function')) throw '';
      module2.exports = util.inherits;
    } catch {
      module2.exports = require_inherits_browser2();
    }
    var util;
  },
});
var require_BufferList = __commonJS({
  'node_modules/through2/node_modules/readable-stream/lib/internal/streams/BufferList.js'(exports2, module2) {
    'use strict';
    function _classCallCheck(instance, Constructor) {
      if (!(instance instanceof Constructor)) throw new TypeError('Cannot call a class as a function');
    }
    var Buffer2 = require_safe_buffer().Buffer,
      util = require('util');
    function copyBuffer(src, target, offset) {
      src.copy(target, offset);
    }
    module2.exports = (function () {
      function BufferList() {
        (_classCallCheck(this, BufferList), (this.head = null), (this.tail = null), (this.length = 0));
      }
      return (
        (BufferList.prototype.push = function (v) {
          var entry = { data: v, next: null };
          (this.length > 0 ? (this.tail.next = entry) : (this.head = entry), (this.tail = entry), ++this.length);
        }),
        (BufferList.prototype.unshift = function (v) {
          var entry = { data: v, next: this.head };
          (this.length === 0 && (this.tail = entry), (this.head = entry), ++this.length);
        }),
        (BufferList.prototype.shift = function () {
          if (this.length !== 0) {
            var ret = this.head.data;
            return (
              this.length === 1 ? (this.head = this.tail = null) : (this.head = this.head.next),
              --this.length,
              ret
            );
          }
        }),
        (BufferList.prototype.clear = function () {
          ((this.head = this.tail = null), (this.length = 0));
        }),
        (BufferList.prototype.join = function (s) {
          if (this.length === 0) return '';
          for (var p = this.head, ret = '' + p.data; (p = p.next); ) ret += s + p.data;
          return ret;
        }),
        (BufferList.prototype.concat = function (n) {
          if (this.length === 0) return Buffer2.alloc(0);
          for (var ret = Buffer2.allocUnsafe(n >>> 0), p = this.head, i = 0; p; )
            (copyBuffer(p.data, ret, i), (i += p.data.length), (p = p.next));
          return ret;
        }),
        BufferList
      );
    })();
    util &&
      util.inspect &&
      util.inspect.custom &&
      (module2.exports.prototype[util.inspect.custom] = function () {
        var obj = util.inspect({ length: this.length });
        return this.constructor.name + ' ' + obj;
      });
  },
});
var require_destroy = __commonJS({
  'node_modules/through2/node_modules/readable-stream/lib/internal/streams/destroy.js'(exports2, module2) {
    'use strict';
    var pna = require_process_nextick_args();
    function destroy(err, cb) {
      var _this = this,
        readableDestroyed = this._readableState && this._readableState.destroyed,
        writableDestroyed = this._writableState && this._writableState.destroyed;
      return readableDestroyed || writableDestroyed
        ? (cb
            ? cb(err)
            : err &&
              (this._writableState
                ? this._writableState.errorEmitted ||
                  ((this._writableState.errorEmitted = !0), pna.nextTick(emitErrorNT, this, err))
                : pna.nextTick(emitErrorNT, this, err)),
          this)
        : (this._readableState && (this._readableState.destroyed = !0),
          this._writableState && (this._writableState.destroyed = !0),
          this._destroy(err || null, function (err2) {
            !cb && err2
              ? _this._writableState
                ? _this._writableState.errorEmitted ||
                  ((_this._writableState.errorEmitted = !0), pna.nextTick(emitErrorNT, _this, err2))
                : pna.nextTick(emitErrorNT, _this, err2)
              : cb && cb(err2);
          }),
          this);
    }
    function undestroy() {
      (this._readableState &&
        ((this._readableState.destroyed = !1),
        (this._readableState.reading = !1),
        (this._readableState.ended = !1),
        (this._readableState.endEmitted = !1)),
        this._writableState &&
          ((this._writableState.destroyed = !1),
          (this._writableState.ended = !1),
          (this._writableState.ending = !1),
          (this._writableState.finalCalled = !1),
          (this._writableState.prefinished = !1),
          (this._writableState.finished = !1),
          (this._writableState.errorEmitted = !1)));
    }
    function emitErrorNT(self2, err) {
      self2.emit('error', err);
    }
    module2.exports = { destroy, undestroy };
  },
});
var require_node = __commonJS({
  'node_modules/util-deprecate/node.js'(exports2, module2) {
    'use strict';
    module2.exports = require('util').deprecate;
  },
});
var require_stream_writable2 = __commonJS({
  'node_modules/through2/node_modules/readable-stream/lib/_stream_writable.js'(exports2, module2) {
    'use strict';
    var pna = require_process_nextick_args();
    module2.exports = Writable;
    function CorkedRequest(state) {
      var _this = this;
      ((this.next = null),
        (this.entry = null),
        (this.finish = function () {
          onCorkedFinish(_this, state);
        }));
    }
    var asyncWrite =
        !process.browser && ['v0.10', 'v0.9.'].indexOf(process.version.slice(0, 5)) > -1 ? setImmediate : pna.nextTick,
      Duplex;
    Writable.WritableState = WritableState;
    var util = Object.create(require_util());
    util.inherits = require_inherits2();
    var internalUtil = { deprecate: require_node() },
      Stream = require_stream(),
      Buffer2 = require_safe_buffer().Buffer,
      OurUint8Array =
        (typeof global < 'u' ? global : typeof window < 'u' ? window : typeof self < 'u' ? self : {}).Uint8Array ||
        function () {};
    function _uint8ArrayToBuffer(chunk) {
      return Buffer2.from(chunk);
    }
    function _isUint8Array(obj) {
      return Buffer2.isBuffer(obj) || obj instanceof OurUint8Array;
    }
    var destroyImpl = require_destroy();
    util.inherits(Writable, Stream);
    function nop() {}
    function WritableState(options, stream) {
      ((Duplex = Duplex || require_stream_duplex2()), (options = options || {}));
      var isDuplex = stream instanceof Duplex;
      ((this.objectMode = !!options.objectMode),
        isDuplex && (this.objectMode = this.objectMode || !!options.writableObjectMode));
      var hwm = options.highWaterMark,
        writableHwm = options.writableHighWaterMark,
        defaultHwm = this.objectMode ? 16 : 16 * 1024;
      (hwm || hwm === 0
        ? (this.highWaterMark = hwm)
        : isDuplex && (writableHwm || writableHwm === 0)
          ? (this.highWaterMark = writableHwm)
          : (this.highWaterMark = defaultHwm),
        (this.highWaterMark = Math.floor(this.highWaterMark)),
        (this.finalCalled = !1),
        (this.needDrain = !1),
        (this.ending = !1),
        (this.ended = !1),
        (this.finished = !1),
        (this.destroyed = !1));
      var noDecode = options.decodeStrings === !1;
      ((this.decodeStrings = !noDecode),
        (this.defaultEncoding = options.defaultEncoding || 'utf8'),
        (this.length = 0),
        (this.writing = !1),
        (this.corked = 0),
        (this.sync = !0),
        (this.bufferProcessing = !1),
        (this.onwrite = function (er) {
          onwrite(stream, er);
        }),
        (this.writecb = null),
        (this.writelen = 0),
        (this.bufferedRequest = null),
        (this.lastBufferedRequest = null),
        (this.pendingcb = 0),
        (this.prefinished = !1),
        (this.errorEmitted = !1),
        (this.bufferedRequestCount = 0),
        (this.corkedRequestsFree = new CorkedRequest(this)));
    }
    WritableState.prototype.getBuffer = function () {
      for (var current = this.bufferedRequest, out = []; current; ) (out.push(current), (current = current.next));
      return out;
    };
    (function () {
      try {
        Object.defineProperty(WritableState.prototype, 'buffer', {
          get: internalUtil.deprecate(
            function () {
              return this.getBuffer();
            },
            '_writableState.buffer is deprecated. Use _writableState.getBuffer instead.',
            'DEP0003'
          ),
        });
      } catch {}
    })();
    var realHasInstance;
    typeof Symbol == 'function' && Symbol.hasInstance && typeof Function.prototype[Symbol.hasInstance] == 'function'
      ? ((realHasInstance = Function.prototype[Symbol.hasInstance]),
        Object.defineProperty(Writable, Symbol.hasInstance, {
          value: function (object) {
            return realHasInstance.call(this, object)
              ? !0
              : this !== Writable
                ? !1
                : object && object._writableState instanceof WritableState;
          },
        }))
      : (realHasInstance = function (object) {
          return object instanceof this;
        });
    function Writable(options) {
      if (
        ((Duplex = Duplex || require_stream_duplex2()),
        !realHasInstance.call(Writable, this) && !(this instanceof Duplex))
      )
        return new Writable(options);
      ((this._writableState = new WritableState(options, this)),
        (this.writable = !0),
        options &&
          (typeof options.write == 'function' && (this._write = options.write),
          typeof options.writev == 'function' && (this._writev = options.writev),
          typeof options.destroy == 'function' && (this._destroy = options.destroy),
          typeof options.final == 'function' && (this._final = options.final)),
        Stream.call(this));
    }
    Writable.prototype.pipe = function () {
      this.emit('error', new Error('Cannot pipe, not readable'));
    };
    function writeAfterEnd(stream, cb) {
      var er = new Error('write after end');
      (stream.emit('error', er), pna.nextTick(cb, er));
    }
    function validChunk(stream, state, chunk, cb) {
      var valid = !0,
        er = !1;
      return (
        chunk === null
          ? (er = new TypeError('May not write null values to stream'))
          : typeof chunk != 'string' &&
            chunk !== void 0 &&
            !state.objectMode &&
            (er = new TypeError('Invalid non-string/buffer chunk')),
        er && (stream.emit('error', er), pna.nextTick(cb, er), (valid = !1)),
        valid
      );
    }
    Writable.prototype.write = function (chunk, encoding, cb) {
      var state = this._writableState,
        ret = !1,
        isBuf = !state.objectMode && _isUint8Array(chunk);
      return (
        isBuf && !Buffer2.isBuffer(chunk) && (chunk = _uint8ArrayToBuffer(chunk)),
        typeof encoding == 'function' && ((cb = encoding), (encoding = null)),
        isBuf ? (encoding = 'buffer') : encoding || (encoding = state.defaultEncoding),
        typeof cb != 'function' && (cb = nop),
        state.ended
          ? writeAfterEnd(this, cb)
          : (isBuf || validChunk(this, state, chunk, cb)) &&
            (state.pendingcb++, (ret = writeOrBuffer(this, state, isBuf, chunk, encoding, cb))),
        ret
      );
    };
    Writable.prototype.cork = function () {
      var state = this._writableState;
      state.corked++;
    };
    Writable.prototype.uncork = function () {
      var state = this._writableState;
      state.corked &&
        (state.corked--,
        !state.writing &&
          !state.corked &&
          !state.bufferProcessing &&
          state.bufferedRequest &&
          clearBuffer(this, state));
    };
    Writable.prototype.setDefaultEncoding = function (encoding) {
      if (
        (typeof encoding == 'string' && (encoding = encoding.toLowerCase()),
        !(
          ['hex', 'utf8', 'utf-8', 'ascii', 'binary', 'base64', 'ucs2', 'ucs-2', 'utf16le', 'utf-16le', 'raw'].indexOf(
            (encoding + '').toLowerCase()
          ) > -1
        ))
      )
        throw new TypeError('Unknown encoding: ' + encoding);
      return ((this._writableState.defaultEncoding = encoding), this);
    };
    function decodeChunk(state, chunk, encoding) {
      return (
        !state.objectMode &&
          state.decodeStrings !== !1 &&
          typeof chunk == 'string' &&
          (chunk = Buffer2.from(chunk, encoding)),
        chunk
      );
    }
    Object.defineProperty(Writable.prototype, 'writableHighWaterMark', {
      enumerable: !1,
      get: function () {
        return this._writableState.highWaterMark;
      },
    });
    function writeOrBuffer(stream, state, isBuf, chunk, encoding, cb) {
      if (!isBuf) {
        var newChunk = decodeChunk(state, chunk, encoding);
        chunk !== newChunk && ((isBuf = !0), (encoding = 'buffer'), (chunk = newChunk));
      }
      var len = state.objectMode ? 1 : chunk.length;
      state.length += len;
      var ret = state.length < state.highWaterMark;
      if ((ret || (state.needDrain = !0), state.writing || state.corked)) {
        var last = state.lastBufferedRequest;
        ((state.lastBufferedRequest = { chunk, encoding, isBuf, callback: cb, next: null }),
          last ? (last.next = state.lastBufferedRequest) : (state.bufferedRequest = state.lastBufferedRequest),
          (state.bufferedRequestCount += 1));
      } else doWrite(stream, state, !1, len, chunk, encoding, cb);
      return ret;
    }
    function doWrite(stream, state, writev, len, chunk, encoding, cb) {
      ((state.writelen = len),
        (state.writecb = cb),
        (state.writing = !0),
        (state.sync = !0),
        writev ? stream._writev(chunk, state.onwrite) : stream._write(chunk, encoding, state.onwrite),
        (state.sync = !1));
    }
    function onwriteError(stream, state, sync, er, cb) {
      (--state.pendingcb,
        sync
          ? (pna.nextTick(cb, er),
            pna.nextTick(finishMaybe, stream, state),
            (stream._writableState.errorEmitted = !0),
            stream.emit('error', er))
          : (cb(er), (stream._writableState.errorEmitted = !0), stream.emit('error', er), finishMaybe(stream, state)));
    }
    function onwriteStateUpdate(state) {
      ((state.writing = !1), (state.writecb = null), (state.length -= state.writelen), (state.writelen = 0));
    }
    function onwrite(stream, er) {
      var state = stream._writableState,
        sync = state.sync,
        cb = state.writecb;
      if ((onwriteStateUpdate(state), er)) onwriteError(stream, state, sync, er, cb);
      else {
        var finished = needFinish(state);
        (!finished && !state.corked && !state.bufferProcessing && state.bufferedRequest && clearBuffer(stream, state),
          sync ? asyncWrite(afterWrite, stream, state, finished, cb) : afterWrite(stream, state, finished, cb));
      }
    }
    function afterWrite(stream, state, finished, cb) {
      (finished || onwriteDrain(stream, state), state.pendingcb--, cb(), finishMaybe(stream, state));
    }
    function onwriteDrain(stream, state) {
      state.length === 0 && state.needDrain && ((state.needDrain = !1), stream.emit('drain'));
    }
    function clearBuffer(stream, state) {
      state.bufferProcessing = !0;
      var entry = state.bufferedRequest;
      if (stream._writev && entry && entry.next) {
        var l = state.bufferedRequestCount,
          buffer = new Array(l),
          holder = state.corkedRequestsFree;
        holder.entry = entry;
        for (var count = 0, allBuffers = !0; entry; )
          ((buffer[count] = entry), entry.isBuf || (allBuffers = !1), (entry = entry.next), (count += 1));
        ((buffer.allBuffers = allBuffers),
          doWrite(stream, state, !0, state.length, buffer, '', holder.finish),
          state.pendingcb++,
          (state.lastBufferedRequest = null),
          holder.next
            ? ((state.corkedRequestsFree = holder.next), (holder.next = null))
            : (state.corkedRequestsFree = new CorkedRequest(state)),
          (state.bufferedRequestCount = 0));
      } else {
        for (; entry; ) {
          var chunk = entry.chunk,
            encoding = entry.encoding,
            cb = entry.callback,
            len = state.objectMode ? 1 : chunk.length;
          if (
            (doWrite(stream, state, !1, len, chunk, encoding, cb),
            (entry = entry.next),
            state.bufferedRequestCount--,
            state.writing)
          )
            break;
        }
        entry === null && (state.lastBufferedRequest = null);
      }
      ((state.bufferedRequest = entry), (state.bufferProcessing = !1));
    }
    Writable.prototype._write = function (chunk, encoding, cb) {
      cb(new Error('_write() is not implemented'));
    };
    Writable.prototype._writev = null;
    Writable.prototype.end = function (chunk, encoding, cb) {
      var state = this._writableState;
      (typeof chunk == 'function'
        ? ((cb = chunk), (chunk = null), (encoding = null))
        : typeof encoding == 'function' && ((cb = encoding), (encoding = null)),
        chunk != null && this.write(chunk, encoding),
        state.corked && ((state.corked = 1), this.uncork()),
        state.ending || endWritable(this, state, cb));
    };
    function needFinish(state) {
      return state.ending && state.length === 0 && state.bufferedRequest === null && !state.finished && !state.writing;
    }
    function callFinal(stream, state) {
      stream._final(function (err) {
        (state.pendingcb--,
          err && stream.emit('error', err),
          (state.prefinished = !0),
          stream.emit('prefinish'),
          finishMaybe(stream, state));
      });
    }
    function prefinish(stream, state) {
      !state.prefinished &&
        !state.finalCalled &&
        (typeof stream._final == 'function'
          ? (state.pendingcb++, (state.finalCalled = !0), pna.nextTick(callFinal, stream, state))
          : ((state.prefinished = !0), stream.emit('prefinish')));
    }
    function finishMaybe(stream, state) {
      var need = needFinish(state);
      return (
        need && (prefinish(stream, state), state.pendingcb === 0 && ((state.finished = !0), stream.emit('finish'))),
        need
      );
    }
    function endWritable(stream, state, cb) {
      ((state.ending = !0),
        finishMaybe(stream, state),
        cb && (state.finished ? pna.nextTick(cb) : stream.once('finish', cb)),
        (state.ended = !0),
        (stream.writable = !1));
    }
    function onCorkedFinish(corkReq, state, err) {
      var entry = corkReq.entry;
      for (corkReq.entry = null; entry; ) {
        var cb = entry.callback;
        (state.pendingcb--, cb(err), (entry = entry.next));
      }
      state.corkedRequestsFree.next = corkReq;
    }
    Object.defineProperty(Writable.prototype, 'destroyed', {
      get: function () {
        return this._writableState === void 0 ? !1 : this._writableState.destroyed;
      },
      set: function (value) {
        this._writableState && (this._writableState.destroyed = value);
      },
    });
    Writable.prototype.destroy = destroyImpl.destroy;
    Writable.prototype._undestroy = destroyImpl.undestroy;
    Writable.prototype._destroy = function (err, cb) {
      (this.end(), cb(err));
    };
  },
});
var require_stream_duplex2 = __commonJS({
  'node_modules/through2/node_modules/readable-stream/lib/_stream_duplex.js'(exports2, module2) {
    'use strict';
    var pna = require_process_nextick_args(),
      objectKeys =
        Object.keys ||
        function (obj) {
          var keys2 = [];
          for (var key in obj) keys2.push(key);
          return keys2;
        };
    module2.exports = Duplex;
    var util = Object.create(require_util());
    util.inherits = require_inherits2();
    var Readable = require_stream_readable2(),
      Writable = require_stream_writable2();
    util.inherits(Duplex, Readable);
    for (keys = objectKeys(Writable.prototype), v = 0; v < keys.length; v++)
      ((method = keys[v]), Duplex.prototype[method] || (Duplex.prototype[method] = Writable.prototype[method]));
    var keys, method, v;
    function Duplex(options) {
      if (!(this instanceof Duplex)) return new Duplex(options);
      (Readable.call(this, options),
        Writable.call(this, options),
        options && options.readable === !1 && (this.readable = !1),
        options && options.writable === !1 && (this.writable = !1),
        (this.allowHalfOpen = !0),
        options && options.allowHalfOpen === !1 && (this.allowHalfOpen = !1),
        this.once('end', onend));
    }
    Object.defineProperty(Duplex.prototype, 'writableHighWaterMark', {
      enumerable: !1,
      get: function () {
        return this._writableState.highWaterMark;
      },
    });
    function onend() {
      this.allowHalfOpen || this._writableState.ended || pna.nextTick(onEndNT, this);
    }
    function onEndNT(self2) {
      self2.end();
    }
    Object.defineProperty(Duplex.prototype, 'destroyed', {
      get: function () {
        return this._readableState === void 0 || this._writableState === void 0
          ? !1
          : this._readableState.destroyed && this._writableState.destroyed;
      },
      set: function (value) {
        this._readableState === void 0 ||
          this._writableState === void 0 ||
          ((this._readableState.destroyed = value), (this._writableState.destroyed = value));
      },
    });
    Duplex.prototype._destroy = function (err, cb) {
      (this.push(null), this.end(), pna.nextTick(cb, err));
    };
  },
});
var require_string_decoder2 = __commonJS({
  'node_modules/through2/node_modules/readable-stream/node_modules/string_decoder/lib/string_decoder.js'(exports2) {
    'use strict';
    var Buffer2 = require_safe_buffer().Buffer,
      isEncoding =
        Buffer2.isEncoding ||
        function (encoding) {
          switch (((encoding = '' + encoding), encoding && encoding.toLowerCase())) {
            case 'hex':
            case 'utf8':
            case 'utf-8':
            case 'ascii':
            case 'binary':
            case 'base64':
            case 'ucs2':
            case 'ucs-2':
            case 'utf16le':
            case 'utf-16le':
            case 'raw':
              return !0;
            default:
              return !1;
          }
        };
    function _normalizeEncoding(enc) {
      if (!enc) return 'utf8';
      for (var retried; ; )
        switch (enc) {
          case 'utf8':
          case 'utf-8':
            return 'utf8';
          case 'ucs2':
          case 'ucs-2':
          case 'utf16le':
          case 'utf-16le':
            return 'utf16le';
          case 'latin1':
          case 'binary':
            return 'latin1';
          case 'base64':
          case 'ascii':
          case 'hex':
            return enc;
          default:
            if (retried) return;
            ((enc = ('' + enc).toLowerCase()), (retried = !0));
        }
    }
    function normalizeEncoding(enc) {
      var nenc = _normalizeEncoding(enc);
      if (typeof nenc != 'string' && (Buffer2.isEncoding === isEncoding || !isEncoding(enc)))
        throw new Error('Unknown encoding: ' + enc);
      return nenc || enc;
    }
    exports2.StringDecoder = StringDecoder;
    function StringDecoder(encoding) {
      this.encoding = normalizeEncoding(encoding);
      var nb;
      switch (this.encoding) {
        case 'utf16le':
          ((this.text = utf16Text), (this.end = utf16End), (nb = 4));
          break;
        case 'utf8':
          ((this.fillLast = utf8FillLast), (nb = 4));
          break;
        case 'base64':
          ((this.text = base64Text), (this.end = base64End), (nb = 3));
          break;
        default:
          ((this.write = simpleWrite), (this.end = simpleEnd));
          return;
      }
      ((this.lastNeed = 0), (this.lastTotal = 0), (this.lastChar = Buffer2.allocUnsafe(nb)));
    }
    StringDecoder.prototype.write = function (buf) {
      if (buf.length === 0) return '';
      var r, i;
      if (this.lastNeed) {
        if (((r = this.fillLast(buf)), r === void 0)) return '';
        ((i = this.lastNeed), (this.lastNeed = 0));
      } else i = 0;
      return i < buf.length ? (r ? r + this.text(buf, i) : this.text(buf, i)) : r || '';
    };
    StringDecoder.prototype.end = utf8End;
    StringDecoder.prototype.text = utf8Text;
    StringDecoder.prototype.fillLast = function (buf) {
      if (this.lastNeed <= buf.length)
        return (
          buf.copy(this.lastChar, this.lastTotal - this.lastNeed, 0, this.lastNeed),
          this.lastChar.toString(this.encoding, 0, this.lastTotal)
        );
      (buf.copy(this.lastChar, this.lastTotal - this.lastNeed, 0, buf.length), (this.lastNeed -= buf.length));
    };
    function utf8CheckByte(byte) {
      return byte <= 127
        ? 0
        : byte >> 5 === 6
          ? 2
          : byte >> 4 === 14
            ? 3
            : byte >> 3 === 30
              ? 4
              : byte >> 6 === 2
                ? -1
                : -2;
    }
    function utf8CheckIncomplete(self2, buf, i) {
      var j = buf.length - 1;
      if (j < i) return 0;
      var nb = utf8CheckByte(buf[j]);
      return nb >= 0
        ? (nb > 0 && (self2.lastNeed = nb - 1), nb)
        : --j < i || nb === -2
          ? 0
          : ((nb = utf8CheckByte(buf[j])),
            nb >= 0
              ? (nb > 0 && (self2.lastNeed = nb - 2), nb)
              : --j < i || nb === -2
                ? 0
                : ((nb = utf8CheckByte(buf[j])),
                  nb >= 0 ? (nb > 0 && (nb === 2 ? (nb = 0) : (self2.lastNeed = nb - 3)), nb) : 0));
    }
    function utf8CheckExtraBytes(self2, buf, p) {
      if ((buf[0] & 192) !== 128) return ((self2.lastNeed = 0), '\uFFFD');
      if (self2.lastNeed > 1 && buf.length > 1) {
        if ((buf[1] & 192) !== 128) return ((self2.lastNeed = 1), '\uFFFD');
        if (self2.lastNeed > 2 && buf.length > 2 && (buf[2] & 192) !== 128) return ((self2.lastNeed = 2), '\uFFFD');
      }
    }
    function utf8FillLast(buf) {
      var p = this.lastTotal - this.lastNeed,
        r = utf8CheckExtraBytes(this, buf, p);
      if (r !== void 0) return r;
      if (this.lastNeed <= buf.length)
        return (buf.copy(this.lastChar, p, 0, this.lastNeed), this.lastChar.toString(this.encoding, 0, this.lastTotal));
      (buf.copy(this.lastChar, p, 0, buf.length), (this.lastNeed -= buf.length));
    }
    function utf8Text(buf, i) {
      var total = utf8CheckIncomplete(this, buf, i);
      if (!this.lastNeed) return buf.toString('utf8', i);
      this.lastTotal = total;
      var end = buf.length - (total - this.lastNeed);
      return (buf.copy(this.lastChar, 0, end), buf.toString('utf8', i, end));
    }
    function utf8End(buf) {
      var r = buf && buf.length ? this.write(buf) : '';
      return this.lastNeed ? r + '\uFFFD' : r;
    }
    function utf16Text(buf, i) {
      if ((buf.length - i) % 2 === 0) {
        var r = buf.toString('utf16le', i);
        if (r) {
          var c = r.charCodeAt(r.length - 1);
          if (c >= 55296 && c <= 56319)
            return (
              (this.lastNeed = 2),
              (this.lastTotal = 4),
              (this.lastChar[0] = buf[buf.length - 2]),
              (this.lastChar[1] = buf[buf.length - 1]),
              r.slice(0, -1)
            );
        }
        return r;
      }
      return (
        (this.lastNeed = 1),
        (this.lastTotal = 2),
        (this.lastChar[0] = buf[buf.length - 1]),
        buf.toString('utf16le', i, buf.length - 1)
      );
    }
    function utf16End(buf) {
      var r = buf && buf.length ? this.write(buf) : '';
      if (this.lastNeed) {
        var end = this.lastTotal - this.lastNeed;
        return r + this.lastChar.toString('utf16le', 0, end);
      }
      return r;
    }
    function base64Text(buf, i) {
      var n = (buf.length - i) % 3;
      return n === 0
        ? buf.toString('base64', i)
        : ((this.lastNeed = 3 - n),
          (this.lastTotal = 3),
          n === 1
            ? (this.lastChar[0] = buf[buf.length - 1])
            : ((this.lastChar[0] = buf[buf.length - 2]), (this.lastChar[1] = buf[buf.length - 1])),
          buf.toString('base64', i, buf.length - n));
    }
    function base64End(buf) {
      var r = buf && buf.length ? this.write(buf) : '';
      return this.lastNeed ? r + this.lastChar.toString('base64', 0, 3 - this.lastNeed) : r;
    }
    function simpleWrite(buf) {
      return buf.toString(this.encoding);
    }
    function simpleEnd(buf) {
      return buf && buf.length ? this.write(buf) : '';
    }
  },
});
var require_stream_readable2 = __commonJS({
  'node_modules/through2/node_modules/readable-stream/lib/_stream_readable.js'(exports2, module2) {
    'use strict';
    var pna = require_process_nextick_args();
    module2.exports = Readable;
    var isArray = require_isarray2(),
      Duplex;
    Readable.ReadableState = ReadableState;
    var EE = require('events').EventEmitter,
      EElistenerCount = function (emitter, type) {
        return emitter.listeners(type).length;
      },
      Stream = require_stream(),
      Buffer2 = require_safe_buffer().Buffer,
      OurUint8Array =
        (typeof global < 'u' ? global : typeof window < 'u' ? window : typeof self < 'u' ? self : {}).Uint8Array ||
        function () {};
    function _uint8ArrayToBuffer(chunk) {
      return Buffer2.from(chunk);
    }
    function _isUint8Array(obj) {
      return Buffer2.isBuffer(obj) || obj instanceof OurUint8Array;
    }
    var util = Object.create(require_util());
    util.inherits = require_inherits2();
    var debugUtil = require('util'),
      debug = void 0;
    debugUtil && debugUtil.debuglog ? (debug = debugUtil.debuglog('stream')) : (debug = function () {});
    var BufferList = require_BufferList(),
      destroyImpl = require_destroy(),
      StringDecoder;
    util.inherits(Readable, Stream);
    var kProxyEvents = ['error', 'close', 'destroy', 'pause', 'resume'];
    function prependListener(emitter, event, fn) {
      if (typeof emitter.prependListener == 'function') return emitter.prependListener(event, fn);
      !emitter._events || !emitter._events[event]
        ? emitter.on(event, fn)
        : isArray(emitter._events[event])
          ? emitter._events[event].unshift(fn)
          : (emitter._events[event] = [fn, emitter._events[event]]);
    }
    function ReadableState(options, stream) {
      ((Duplex = Duplex || require_stream_duplex2()), (options = options || {}));
      var isDuplex = stream instanceof Duplex;
      ((this.objectMode = !!options.objectMode),
        isDuplex && (this.objectMode = this.objectMode || !!options.readableObjectMode));
      var hwm = options.highWaterMark,
        readableHwm = options.readableHighWaterMark,
        defaultHwm = this.objectMode ? 16 : 16 * 1024;
      (hwm || hwm === 0
        ? (this.highWaterMark = hwm)
        : isDuplex && (readableHwm || readableHwm === 0)
          ? (this.highWaterMark = readableHwm)
          : (this.highWaterMark = defaultHwm),
        (this.highWaterMark = Math.floor(this.highWaterMark)),
        (this.buffer = new BufferList()),
        (this.length = 0),
        (this.pipes = null),
        (this.pipesCount = 0),
        (this.flowing = null),
        (this.ended = !1),
        (this.endEmitted = !1),
        (this.reading = !1),
        (this.sync = !0),
        (this.needReadable = !1),
        (this.emittedReadable = !1),
        (this.readableListening = !1),
        (this.resumeScheduled = !1),
        (this.destroyed = !1),
        (this.defaultEncoding = options.defaultEncoding || 'utf8'),
        (this.awaitDrain = 0),
        (this.readingMore = !1),
        (this.decoder = null),
        (this.encoding = null),
        options.encoding &&
          (StringDecoder || (StringDecoder = require_string_decoder2().StringDecoder),
          (this.decoder = new StringDecoder(options.encoding)),
          (this.encoding = options.encoding)));
    }
    function Readable(options) {
      if (((Duplex = Duplex || require_stream_duplex2()), !(this instanceof Readable))) return new Readable(options);
      ((this._readableState = new ReadableState(options, this)),
        (this.readable = !0),
        options &&
          (typeof options.read == 'function' && (this._read = options.read),
          typeof options.destroy == 'function' && (this._destroy = options.destroy)),
        Stream.call(this));
    }
    Object.defineProperty(Readable.prototype, 'destroyed', {
      get: function () {
        return this._readableState === void 0 ? !1 : this._readableState.destroyed;
      },
      set: function (value) {
        this._readableState && (this._readableState.destroyed = value);
      },
    });
    Readable.prototype.destroy = destroyImpl.destroy;
    Readable.prototype._undestroy = destroyImpl.undestroy;
    Readable.prototype._destroy = function (err, cb) {
      (this.push(null), cb(err));
    };
    Readable.prototype.push = function (chunk, encoding) {
      var state = this._readableState,
        skipChunkCheck;
      return (
        state.objectMode
          ? (skipChunkCheck = !0)
          : typeof chunk == 'string' &&
            ((encoding = encoding || state.defaultEncoding),
            encoding !== state.encoding && ((chunk = Buffer2.from(chunk, encoding)), (encoding = '')),
            (skipChunkCheck = !0)),
        readableAddChunk(this, chunk, encoding, !1, skipChunkCheck)
      );
    };
    Readable.prototype.unshift = function (chunk) {
      return readableAddChunk(this, chunk, null, !0, !1);
    };
    function readableAddChunk(stream, chunk, encoding, addToFront, skipChunkCheck) {
      var state = stream._readableState;
      if (chunk === null) ((state.reading = !1), onEofChunk(stream, state));
      else {
        var er;
        (skipChunkCheck || (er = chunkInvalid(state, chunk)),
          er
            ? stream.emit('error', er)
            : state.objectMode || (chunk && chunk.length > 0)
              ? (typeof chunk != 'string' &&
                  !state.objectMode &&
                  Object.getPrototypeOf(chunk) !== Buffer2.prototype &&
                  (chunk = _uint8ArrayToBuffer(chunk)),
                addToFront
                  ? state.endEmitted
                    ? stream.emit('error', new Error('stream.unshift() after end event'))
                    : addChunk(stream, state, chunk, !0)
                  : state.ended
                    ? stream.emit('error', new Error('stream.push() after EOF'))
                    : ((state.reading = !1),
                      state.decoder && !encoding
                        ? ((chunk = state.decoder.write(chunk)),
                          state.objectMode || chunk.length !== 0
                            ? addChunk(stream, state, chunk, !1)
                            : maybeReadMore(stream, state))
                        : addChunk(stream, state, chunk, !1)))
              : addToFront || (state.reading = !1));
      }
      return needMoreData(state);
    }
    function addChunk(stream, state, chunk, addToFront) {
      (state.flowing && state.length === 0 && !state.sync
        ? (stream.emit('data', chunk), stream.read(0))
        : ((state.length += state.objectMode ? 1 : chunk.length),
          addToFront ? state.buffer.unshift(chunk) : state.buffer.push(chunk),
          state.needReadable && emitReadable(stream)),
        maybeReadMore(stream, state));
    }
    function chunkInvalid(state, chunk) {
      var er;
      return (
        !_isUint8Array(chunk) &&
          typeof chunk != 'string' &&
          chunk !== void 0 &&
          !state.objectMode &&
          (er = new TypeError('Invalid non-string/buffer chunk')),
        er
      );
    }
    function needMoreData(state) {
      return !state.ended && (state.needReadable || state.length < state.highWaterMark || state.length === 0);
    }
    Readable.prototype.isPaused = function () {
      return this._readableState.flowing === !1;
    };
    Readable.prototype.setEncoding = function (enc) {
      return (
        StringDecoder || (StringDecoder = require_string_decoder2().StringDecoder),
        (this._readableState.decoder = new StringDecoder(enc)),
        (this._readableState.encoding = enc),
        this
      );
    };
    var MAX_HWM = 8388608;
    function computeNewHighWaterMark(n) {
      return (
        n >= MAX_HWM
          ? (n = MAX_HWM)
          : (n--, (n |= n >>> 1), (n |= n >>> 2), (n |= n >>> 4), (n |= n >>> 8), (n |= n >>> 16), n++),
        n
      );
    }
    function howMuchToRead(n, state) {
      return n <= 0 || (state.length === 0 && state.ended)
        ? 0
        : state.objectMode
          ? 1
          : n !== n
            ? state.flowing && state.length
              ? state.buffer.head.data.length
              : state.length
            : (n > state.highWaterMark && (state.highWaterMark = computeNewHighWaterMark(n)),
              n <= state.length ? n : state.ended ? state.length : ((state.needReadable = !0), 0));
    }
    Readable.prototype.read = function (n) {
      (debug('read', n), (n = parseInt(n, 10)));
      var state = this._readableState,
        nOrig = n;
      if (
        (n !== 0 && (state.emittedReadable = !1),
        n === 0 && state.needReadable && (state.length >= state.highWaterMark || state.ended))
      )
        return (
          debug('read: emitReadable', state.length, state.ended),
          state.length === 0 && state.ended ? endReadable(this) : emitReadable(this),
          null
        );
      if (((n = howMuchToRead(n, state)), n === 0 && state.ended))
        return (state.length === 0 && endReadable(this), null);
      var doRead = state.needReadable;
      (debug('need readable', doRead),
        (state.length === 0 || state.length - n < state.highWaterMark) &&
          ((doRead = !0), debug('length less than watermark', doRead)),
        state.ended || state.reading
          ? ((doRead = !1), debug('reading or ended', doRead))
          : doRead &&
            (debug('do read'),
            (state.reading = !0),
            (state.sync = !0),
            state.length === 0 && (state.needReadable = !0),
            this._read(state.highWaterMark),
            (state.sync = !1),
            state.reading || (n = howMuchToRead(nOrig, state))));
      var ret;
      return (
        n > 0 ? (ret = fromList(n, state)) : (ret = null),
        ret === null ? ((state.needReadable = !0), (n = 0)) : (state.length -= n),
        state.length === 0 &&
          (state.ended || (state.needReadable = !0), nOrig !== n && state.ended && endReadable(this)),
        ret !== null && this.emit('data', ret),
        ret
      );
    };
    function onEofChunk(stream, state) {
      if (!state.ended) {
        if (state.decoder) {
          var chunk = state.decoder.end();
          chunk && chunk.length && (state.buffer.push(chunk), (state.length += state.objectMode ? 1 : chunk.length));
        }
        ((state.ended = !0), emitReadable(stream));
      }
    }
    function emitReadable(stream) {
      var state = stream._readableState;
      ((state.needReadable = !1),
        state.emittedReadable ||
          (debug('emitReadable', state.flowing),
          (state.emittedReadable = !0),
          state.sync ? pna.nextTick(emitReadable_, stream) : emitReadable_(stream)));
    }
    function emitReadable_(stream) {
      (debug('emit readable'), stream.emit('readable'), flow(stream));
    }
    function maybeReadMore(stream, state) {
      state.readingMore || ((state.readingMore = !0), pna.nextTick(maybeReadMore_, stream, state));
    }
    function maybeReadMore_(stream, state) {
      for (
        var len = state.length;
        !state.reading &&
        !state.flowing &&
        !state.ended &&
        state.length < state.highWaterMark &&
        (debug('maybeReadMore read 0'), stream.read(0), len !== state.length);
      )
        len = state.length;
      state.readingMore = !1;
    }
    Readable.prototype._read = function (n) {
      this.emit('error', new Error('_read() is not implemented'));
    };
    Readable.prototype.pipe = function (dest2, pipeOpts) {
      var src = this,
        state = this._readableState;
      switch (state.pipesCount) {
        case 0:
          state.pipes = dest2;
          break;
        case 1:
          state.pipes = [state.pipes, dest2];
          break;
        default:
          state.pipes.push(dest2);
          break;
      }
      ((state.pipesCount += 1), debug('pipe count=%d opts=%j', state.pipesCount, pipeOpts));
      var doEnd = (!pipeOpts || pipeOpts.end !== !1) && dest2 !== process.stdout && dest2 !== process.stderr,
        endFn = doEnd ? onend : unpipe;
      (state.endEmitted ? pna.nextTick(endFn) : src.once('end', endFn), dest2.on('unpipe', onunpipe));
      function onunpipe(readable, unpipeInfo) {
        (debug('onunpipe'),
          readable === src && unpipeInfo && unpipeInfo.hasUnpiped === !1 && ((unpipeInfo.hasUnpiped = !0), cleanup()));
      }
      function onend() {
        (debug('onend'), dest2.end());
      }
      var ondrain = pipeOnDrain(src);
      dest2.on('drain', ondrain);
      var cleanedUp = !1;
      function cleanup() {
        (debug('cleanup'),
          dest2.removeListener('close', onclose),
          dest2.removeListener('finish', onfinish),
          dest2.removeListener('drain', ondrain),
          dest2.removeListener('error', onerror),
          dest2.removeListener('unpipe', onunpipe),
          src.removeListener('end', onend),
          src.removeListener('end', unpipe),
          src.removeListener('data', ondata),
          (cleanedUp = !0),
          state.awaitDrain && (!dest2._writableState || dest2._writableState.needDrain) && ondrain());
      }
      var increasedAwaitDrain = !1;
      src.on('data', ondata);
      function ondata(chunk) {
        (debug('ondata'), (increasedAwaitDrain = !1));
        var ret = dest2.write(chunk);
        ret === !1 &&
          !increasedAwaitDrain &&
          (((state.pipesCount === 1 && state.pipes === dest2) ||
            (state.pipesCount > 1 && indexOf(state.pipes, dest2) !== -1)) &&
            !cleanedUp &&
            (debug('false write response, pause', state.awaitDrain), state.awaitDrain++, (increasedAwaitDrain = !0)),
          src.pause());
      }
      function onerror(er) {
        (debug('onerror', er),
          unpipe(),
          dest2.removeListener('error', onerror),
          EElistenerCount(dest2, 'error') === 0 && dest2.emit('error', er));
      }
      prependListener(dest2, 'error', onerror);
      function onclose() {
        (dest2.removeListener('finish', onfinish), unpipe());
      }
      dest2.once('close', onclose);
      function onfinish() {
        (debug('onfinish'), dest2.removeListener('close', onclose), unpipe());
      }
      dest2.once('finish', onfinish);
      function unpipe() {
        (debug('unpipe'), src.unpipe(dest2));
      }
      return (dest2.emit('pipe', src), state.flowing || (debug('pipe resume'), src.resume()), dest2);
    };
    function pipeOnDrain(src) {
      return function () {
        var state = src._readableState;
        (debug('pipeOnDrain', state.awaitDrain),
          state.awaitDrain && state.awaitDrain--,
          state.awaitDrain === 0 && EElistenerCount(src, 'data') && ((state.flowing = !0), flow(src)));
      };
    }
    Readable.prototype.unpipe = function (dest2) {
      var state = this._readableState,
        unpipeInfo = { hasUnpiped: !1 };
      if (state.pipesCount === 0) return this;
      if (state.pipesCount === 1)
        return dest2 && dest2 !== state.pipes
          ? this
          : (dest2 || (dest2 = state.pipes),
            (state.pipes = null),
            (state.pipesCount = 0),
            (state.flowing = !1),
            dest2 && dest2.emit('unpipe', this, unpipeInfo),
            this);
      if (!dest2) {
        var dests = state.pipes,
          len = state.pipesCount;
        ((state.pipes = null), (state.pipesCount = 0), (state.flowing = !1));
        for (var i = 0; i < len; i++) dests[i].emit('unpipe', this, { hasUnpiped: !1 });
        return this;
      }
      var index = indexOf(state.pipes, dest2);
      return index === -1
        ? this
        : (state.pipes.splice(index, 1),
          (state.pipesCount -= 1),
          state.pipesCount === 1 && (state.pipes = state.pipes[0]),
          dest2.emit('unpipe', this, unpipeInfo),
          this);
    };
    Readable.prototype.on = function (ev, fn) {
      var res = Stream.prototype.on.call(this, ev, fn);
      if (ev === 'data') this._readableState.flowing !== !1 && this.resume();
      else if (ev === 'readable') {
        var state = this._readableState;
        !state.endEmitted &&
          !state.readableListening &&
          ((state.readableListening = state.needReadable = !0),
          (state.emittedReadable = !1),
          state.reading ? state.length && emitReadable(this) : pna.nextTick(nReadingNextTick, this));
      }
      return res;
    };
    Readable.prototype.addListener = Readable.prototype.on;
    function nReadingNextTick(self2) {
      (debug('readable nexttick read 0'), self2.read(0));
    }
    Readable.prototype.resume = function () {
      var state = this._readableState;
      return (state.flowing || (debug('resume'), (state.flowing = !0), resume(this, state)), this);
    };
    function resume(stream, state) {
      state.resumeScheduled || ((state.resumeScheduled = !0), pna.nextTick(resume_, stream, state));
    }
    function resume_(stream, state) {
      (state.reading || (debug('resume read 0'), stream.read(0)),
        (state.resumeScheduled = !1),
        (state.awaitDrain = 0),
        stream.emit('resume'),
        flow(stream),
        state.flowing && !state.reading && stream.read(0));
    }
    Readable.prototype.pause = function () {
      return (
        debug('call pause flowing=%j', this._readableState.flowing),
        this._readableState.flowing !== !1 && (debug('pause'), (this._readableState.flowing = !1), this.emit('pause')),
        this
      );
    };
    function flow(stream) {
      var state = stream._readableState;
      for (debug('flow', state.flowing); state.flowing && stream.read() !== null; );
    }
    Readable.prototype.wrap = function (stream) {
      var _this = this,
        state = this._readableState,
        paused = !1;
      (stream.on('end', function () {
        if ((debug('wrapped end'), state.decoder && !state.ended)) {
          var chunk = state.decoder.end();
          chunk && chunk.length && _this.push(chunk);
        }
        _this.push(null);
      }),
        stream.on('data', function (chunk) {
          if (
            (debug('wrapped data'),
            state.decoder && (chunk = state.decoder.write(chunk)),
            !(state.objectMode && chunk == null) && !(!state.objectMode && (!chunk || !chunk.length)))
          ) {
            var ret = _this.push(chunk);
            ret || ((paused = !0), stream.pause());
          }
        }));
      for (var i in stream)
        this[i] === void 0 &&
          typeof stream[i] == 'function' &&
          (this[i] = (function (method) {
            return function () {
              return stream[method].apply(stream, arguments);
            };
          })(i));
      for (var n = 0; n < kProxyEvents.length; n++) stream.on(kProxyEvents[n], this.emit.bind(this, kProxyEvents[n]));
      return (
        (this._read = function (n2) {
          (debug('wrapped _read', n2), paused && ((paused = !1), stream.resume()));
        }),
        this
      );
    };
    Object.defineProperty(Readable.prototype, 'readableHighWaterMark', {
      enumerable: !1,
      get: function () {
        return this._readableState.highWaterMark;
      },
    });
    Readable._fromList = fromList;
    function fromList(n, state) {
      if (state.length === 0) return null;
      var ret;
      return (
        state.objectMode
          ? (ret = state.buffer.shift())
          : !n || n >= state.length
            ? (state.decoder
                ? (ret = state.buffer.join(''))
                : state.buffer.length === 1
                  ? (ret = state.buffer.head.data)
                  : (ret = state.buffer.concat(state.length)),
              state.buffer.clear())
            : (ret = fromListPartial(n, state.buffer, state.decoder)),
        ret
      );
    }
    function fromListPartial(n, list, hasStrings) {
      var ret;
      return (
        n < list.head.data.length
          ? ((ret = list.head.data.slice(0, n)), (list.head.data = list.head.data.slice(n)))
          : n === list.head.data.length
            ? (ret = list.shift())
            : (ret = hasStrings ? copyFromBufferString(n, list) : copyFromBuffer(n, list)),
        ret
      );
    }
    function copyFromBufferString(n, list) {
      var p = list.head,
        c = 1,
        ret = p.data;
      for (n -= ret.length; (p = p.next); ) {
        var str = p.data,
          nb = n > str.length ? str.length : n;
        if ((nb === str.length ? (ret += str) : (ret += str.slice(0, n)), (n -= nb), n === 0)) {
          nb === str.length
            ? (++c, p.next ? (list.head = p.next) : (list.head = list.tail = null))
            : ((list.head = p), (p.data = str.slice(nb)));
          break;
        }
        ++c;
      }
      return ((list.length -= c), ret);
    }
    function copyFromBuffer(n, list) {
      var ret = Buffer2.allocUnsafe(n),
        p = list.head,
        c = 1;
      for (p.data.copy(ret), n -= p.data.length; (p = p.next); ) {
        var buf = p.data,
          nb = n > buf.length ? buf.length : n;
        if ((buf.copy(ret, ret.length - n, 0, nb), (n -= nb), n === 0)) {
          nb === buf.length
            ? (++c, p.next ? (list.head = p.next) : (list.head = list.tail = null))
            : ((list.head = p), (p.data = buf.slice(nb)));
          break;
        }
        ++c;
      }
      return ((list.length -= c), ret);
    }
    function endReadable(stream) {
      var state = stream._readableState;
      if (state.length > 0) throw new Error('"endReadable()" called on non-empty stream');
      state.endEmitted || ((state.ended = !0), pna.nextTick(endReadableNT, state, stream));
    }
    function endReadableNT(state, stream) {
      !state.endEmitted && state.length === 0 && ((state.endEmitted = !0), (stream.readable = !1), stream.emit('end'));
    }
    function indexOf(xs, x) {
      for (var i = 0, l = xs.length; i < l; i++) if (xs[i] === x) return i;
      return -1;
    }
  },
});
var require_stream_transform2 = __commonJS({
  'node_modules/through2/node_modules/readable-stream/lib/_stream_transform.js'(exports2, module2) {
    'use strict';
    module2.exports = Transform;
    var Duplex = require_stream_duplex2(),
      util = Object.create(require_util());
    util.inherits = require_inherits2();
    util.inherits(Transform, Duplex);
    function afterTransform(er, data) {
      var ts = this._transformState;
      ts.transforming = !1;
      var cb = ts.writecb;
      if (!cb) return this.emit('error', new Error('write callback called multiple times'));
      ((ts.writechunk = null), (ts.writecb = null), data != null && this.push(data), cb(er));
      var rs = this._readableState;
      ((rs.reading = !1), (rs.needReadable || rs.length < rs.highWaterMark) && this._read(rs.highWaterMark));
    }
    function Transform(options) {
      if (!(this instanceof Transform)) return new Transform(options);
      (Duplex.call(this, options),
        (this._transformState = {
          afterTransform: afterTransform.bind(this),
          needTransform: !1,
          transforming: !1,
          writecb: null,
          writechunk: null,
          writeencoding: null,
        }),
        (this._readableState.needReadable = !0),
        (this._readableState.sync = !1),
        options &&
          (typeof options.transform == 'function' && (this._transform = options.transform),
          typeof options.flush == 'function' && (this._flush = options.flush)),
        this.on('prefinish', prefinish));
    }
    function prefinish() {
      var _this = this;
      typeof this._flush == 'function'
        ? this._flush(function (er, data) {
            done(_this, er, data);
          })
        : done(this, null, null);
    }
    Transform.prototype.push = function (chunk, encoding) {
      return ((this._transformState.needTransform = !1), Duplex.prototype.push.call(this, chunk, encoding));
    };
    Transform.prototype._transform = function (chunk, encoding, cb) {
      throw new Error('_transform() is not implemented');
    };
    Transform.prototype._write = function (chunk, encoding, cb) {
      var ts = this._transformState;
      if (((ts.writecb = cb), (ts.writechunk = chunk), (ts.writeencoding = encoding), !ts.transforming)) {
        var rs = this._readableState;
        (ts.needTransform || rs.needReadable || rs.length < rs.highWaterMark) && this._read(rs.highWaterMark);
      }
    };
    Transform.prototype._read = function (n) {
      var ts = this._transformState;
      ts.writechunk !== null && ts.writecb && !ts.transforming
        ? ((ts.transforming = !0), this._transform(ts.writechunk, ts.writeencoding, ts.afterTransform))
        : (ts.needTransform = !0);
    };
    Transform.prototype._destroy = function (err, cb) {
      var _this2 = this;
      Duplex.prototype._destroy.call(this, err, function (err2) {
        (cb(err2), _this2.emit('close'));
      });
    };
    function done(stream, er, data) {
      if (er) return stream.emit('error', er);
      if ((data != null && stream.push(data), stream._writableState.length))
        throw new Error('Calling transform done when ws.length != 0');
      if (stream._transformState.transforming) throw new Error('Calling transform done when still transforming');
      return stream.push(null);
    }
  },
});
var require_stream_passthrough2 = __commonJS({
  'node_modules/through2/node_modules/readable-stream/lib/_stream_passthrough.js'(exports2, module2) {
    'use strict';
    module2.exports = PassThrough;
    var Transform = require_stream_transform2(),
      util = Object.create(require_util());
    util.inherits = require_inherits2();
    util.inherits(PassThrough, Transform);
    function PassThrough(options) {
      if (!(this instanceof PassThrough)) return new PassThrough(options);
      Transform.call(this, options);
    }
    PassThrough.prototype._transform = function (chunk, encoding, cb) {
      cb(null, chunk);
    };
  },
});
var require_readable2 = __commonJS({
  'node_modules/through2/node_modules/readable-stream/readable.js'(exports2, module2) {
    'use strict';
    var Stream = require('stream');
    process.env.READABLE_STREAM === 'disable' && Stream
      ? ((module2.exports = Stream),
        (exports2 = module2.exports = Stream.Readable),
        (exports2.Readable = Stream.Readable),
        (exports2.Writable = Stream.Writable),
        (exports2.Duplex = Stream.Duplex),
        (exports2.Transform = Stream.Transform),
        (exports2.PassThrough = Stream.PassThrough),
        (exports2.Stream = Stream))
      : ((exports2 = module2.exports = require_stream_readable2()),
        (exports2.Stream = Stream || exports2),
        (exports2.Readable = exports2),
        (exports2.Writable = require_stream_writable2()),
        (exports2.Duplex = require_stream_duplex2()),
        (exports2.Transform = require_stream_transform2()),
        (exports2.PassThrough = require_stream_passthrough2()));
  },
});
var require_immutable = __commonJS({
  'node_modules/xtend/immutable.js'(exports2, module2) {
    'use strict';
    module2.exports = extend;
    var hasOwnProperty = Object.prototype.hasOwnProperty;
    function extend() {
      for (var target = {}, i = 0; i < arguments.length; i++) {
        var source = arguments[i];
        for (var key in source) hasOwnProperty.call(source, key) && (target[key] = source[key]);
      }
      return target;
    }
  },
});
var require_through2 = __commonJS({
  'node_modules/through2/through2.js'(exports2, module2) {
    'use strict';
    var Transform = require_readable2().Transform,
      inherits = require('util').inherits,
      xtend = require_immutable();
    function DestroyableTransform(opts) {
      (Transform.call(this, opts), (this._destroyed = !1));
    }
    inherits(DestroyableTransform, Transform);
    DestroyableTransform.prototype.destroy = function (err) {
      if (!this._destroyed) {
        this._destroyed = !0;
        var self2 = this;
        process.nextTick(function () {
          (err && self2.emit('error', err), self2.emit('close'));
        });
      }
    };
    function noop(chunk, enc, callback) {
      callback(null, chunk);
    }
    function through2(construct) {
      return function (options, transform, flush) {
        return (
          typeof options == 'function' && ((flush = transform), (transform = options), (options = {})),
          typeof transform != 'function' && (transform = noop),
          typeof flush != 'function' && (flush = null),
          construct(options, transform, flush)
        );
      };
    }
    module2.exports = through2(function (options, transform, flush) {
      var t2 = new DestroyableTransform(options);
      return ((t2._transform = transform), flush && (t2._flush = flush), t2);
    });
    module2.exports.ctor = through2(function (options, transform, flush) {
      function Through2(override) {
        if (!(this instanceof Through2)) return new Through2(override);
        ((this.options = xtend(options, override)), DestroyableTransform.call(this, this.options));
      }
      return (
        inherits(Through2, DestroyableTransform),
        (Through2.prototype._transform = transform),
        flush && (Through2.prototype._flush = flush),
        Through2
      );
    });
    module2.exports.obj = through2(function (options, transform, flush) {
      var t2 = new DestroyableTransform(xtend({ objectMode: !0, highWaterMark: 16 }, options));
      return ((t2._transform = transform), flush && (t2._flush = flush), t2);
    });
  },
});
var require_raw = __commonJS({
  'node_modules/asap/raw.js'(exports2, module2) {
    'use strict';
    var domain,
      hasSetImmediate = typeof setImmediate == 'function';
    module2.exports = rawAsap;
    function rawAsap(task) {
      (queue.length || (requestFlush(), (flushing = !0)), (queue[queue.length] = task));
    }
    var queue = [],
      flushing = !1,
      index = 0,
      capacity = 1024;
    function flush() {
      for (; index < queue.length; ) {
        var currentIndex = index;
        if (((index = index + 1), queue[currentIndex].call(), index > capacity)) {
          for (var scan = 0, newLength = queue.length - index; scan < newLength; scan++)
            queue[scan] = queue[scan + index];
          ((queue.length -= index), (index = 0));
        }
      }
      ((queue.length = 0), (index = 0), (flushing = !1));
    }
    rawAsap.requestFlush = requestFlush;
    function requestFlush() {
      var parentDomain = process.domain;
      (parentDomain && (domain || (domain = require('domain')), (domain.active = process.domain = null)),
        flushing && hasSetImmediate ? setImmediate(flush) : process.nextTick(flush),
        parentDomain && (domain.active = process.domain = parentDomain));
    }
  },
});
var require_core = __commonJS({
  'node_modules/promise/lib/core.js'(exports2, module2) {
    'use strict';
    var asap = require_raw();
    function noop() {}
    var LAST_ERROR = null,
      IS_ERROR = {};
    function getThen(obj) {
      try {
        return obj.then;
      } catch (ex) {
        return ((LAST_ERROR = ex), IS_ERROR);
      }
    }
    function tryCallOne(fn, a) {
      try {
        return fn(a);
      } catch (ex) {
        return ((LAST_ERROR = ex), IS_ERROR);
      }
    }
    function tryCallTwo(fn, a, b) {
      try {
        fn(a, b);
      } catch (ex) {
        return ((LAST_ERROR = ex), IS_ERROR);
      }
    }
    module2.exports = Promise2;
    function Promise2(fn) {
      if (typeof this != 'object') throw new TypeError('Promises must be constructed via new');
      if (typeof fn != 'function') throw new TypeError("Promise constructor's argument is not a function");
      ((this._40 = 0), (this._65 = 0), (this._55 = null), (this._72 = null), fn !== noop && doResolve(fn, this));
    }
    Promise2._37 = null;
    Promise2._87 = null;
    Promise2._61 = noop;
    Promise2.prototype.then = function (onFulfilled, onRejected) {
      if (this.constructor !== Promise2) return safeThen(this, onFulfilled, onRejected);
      var res = new Promise2(noop);
      return (handle(this, new Handler(onFulfilled, onRejected, res)), res);
    };
    function safeThen(self2, onFulfilled, onRejected) {
      return new self2.constructor(function (resolve2, reject2) {
        var res = new Promise2(noop);
        (res.then(resolve2, reject2), handle(self2, new Handler(onFulfilled, onRejected, res)));
      });
    }
    function handle(self2, deferred) {
      for (; self2._65 === 3; ) self2 = self2._55;
      if ((Promise2._37 && Promise2._37(self2), self2._65 === 0)) {
        if (self2._40 === 0) {
          ((self2._40 = 1), (self2._72 = deferred));
          return;
        }
        if (self2._40 === 1) {
          ((self2._40 = 2), (self2._72 = [self2._72, deferred]));
          return;
        }
        self2._72.push(deferred);
        return;
      }
      handleResolved(self2, deferred);
    }
    function handleResolved(self2, deferred) {
      asap(function () {
        var cb = self2._65 === 1 ? deferred.onFulfilled : deferred.onRejected;
        if (cb === null) {
          self2._65 === 1 ? resolve(deferred.promise, self2._55) : reject(deferred.promise, self2._55);
          return;
        }
        var ret = tryCallOne(cb, self2._55);
        ret === IS_ERROR ? reject(deferred.promise, LAST_ERROR) : resolve(deferred.promise, ret);
      });
    }
    function resolve(self2, newValue) {
      if (newValue === self2) return reject(self2, new TypeError('A promise cannot be resolved with itself.'));
      if (newValue && (typeof newValue == 'object' || typeof newValue == 'function')) {
        var then = getThen(newValue);
        if (then === IS_ERROR) return reject(self2, LAST_ERROR);
        if (then === self2.then && newValue instanceof Promise2) {
          ((self2._65 = 3), (self2._55 = newValue), finale(self2));
          return;
        } else if (typeof then == 'function') {
          doResolve(then.bind(newValue), self2);
          return;
        }
      }
      ((self2._65 = 1), (self2._55 = newValue), finale(self2));
    }
    function reject(self2, newValue) {
      ((self2._65 = 2), (self2._55 = newValue), Promise2._87 && Promise2._87(self2, newValue), finale(self2));
    }
    function finale(self2) {
      if ((self2._40 === 1 && (handle(self2, self2._72), (self2._72 = null)), self2._40 === 2)) {
        for (var i = 0; i < self2._72.length; i++) handle(self2, self2._72[i]);
        self2._72 = null;
      }
    }
    function Handler(onFulfilled, onRejected, promise) {
      ((this.onFulfilled = typeof onFulfilled == 'function' ? onFulfilled : null),
        (this.onRejected = typeof onRejected == 'function' ? onRejected : null),
        (this.promise = promise));
    }
    function doResolve(fn, promise) {
      var done = !1,
        res = tryCallTwo(
          fn,
          function (value) {
            done || ((done = !0), resolve(promise, value));
          },
          function (reason) {
            done || ((done = !0), reject(promise, reason));
          }
        );
      !done && res === IS_ERROR && ((done = !0), reject(promise, LAST_ERROR));
    }
  },
});
var require_done = __commonJS({
  'node_modules/promise/lib/done.js'(exports2, module2) {
    'use strict';
    var Promise2 = require_core();
    module2.exports = Promise2;
    Promise2.prototype.done = function (onFulfilled, onRejected) {
      var self2 = arguments.length ? this.then.apply(this, arguments) : this;
      self2.then(null, function (err) {
        setTimeout(function () {
          throw err;
        }, 0);
      });
    };
  },
});
var require_finally = __commonJS({
  'node_modules/promise/lib/finally.js'(exports2, module2) {
    'use strict';
    var Promise2 = require_core();
    module2.exports = Promise2;
    Promise2.prototype.finally = function (f) {
      return this.then(
        function (value) {
          return Promise2.resolve(f()).then(function () {
            return value;
          });
        },
        function (err) {
          return Promise2.resolve(f()).then(function () {
            throw err;
          });
        }
      );
    };
  },
});
var require_es6_extensions = __commonJS({
  'node_modules/promise/lib/es6-extensions.js'(exports2, module2) {
    'use strict';
    var Promise2 = require_core();
    module2.exports = Promise2;
    var TRUE = valuePromise(!0),
      FALSE = valuePromise(!1),
      NULL = valuePromise(null),
      UNDEFINED = valuePromise(void 0),
      ZERO = valuePromise(0),
      EMPTYSTRING = valuePromise('');
    function valuePromise(value) {
      var p = new Promise2(Promise2._61);
      return ((p._65 = 1), (p._55 = value), p);
    }
    Promise2.resolve = function (value) {
      if (value instanceof Promise2) return value;
      if (value === null) return NULL;
      if (value === void 0) return UNDEFINED;
      if (value === !0) return TRUE;
      if (value === !1) return FALSE;
      if (value === 0) return ZERO;
      if (value === '') return EMPTYSTRING;
      if (typeof value == 'object' || typeof value == 'function')
        try {
          var then = value.then;
          if (typeof then == 'function') return new Promise2(then.bind(value));
        } catch (ex) {
          return new Promise2(function (resolve, reject) {
            reject(ex);
          });
        }
      return valuePromise(value);
    };
    Promise2.all = function (arr) {
      var args = Array.prototype.slice.call(arr);
      return new Promise2(function (resolve, reject) {
        if (args.length === 0) return resolve([]);
        var remaining = args.length;
        function res(i2, val) {
          if (val && (typeof val == 'object' || typeof val == 'function'))
            if (val instanceof Promise2 && val.then === Promise2.prototype.then) {
              for (; val._65 === 3; ) val = val._55;
              if (val._65 === 1) return res(i2, val._55);
              (val._65 === 2 && reject(val._55),
                val.then(function (val2) {
                  res(i2, val2);
                }, reject));
              return;
            } else {
              var then = val.then;
              if (typeof then == 'function') {
                var p = new Promise2(then.bind(val));
                p.then(function (val2) {
                  res(i2, val2);
                }, reject);
                return;
              }
            }
          ((args[i2] = val), --remaining === 0 && resolve(args));
        }
        for (var i = 0; i < args.length; i++) res(i, args[i]);
      });
    };
    Promise2.reject = function (value) {
      return new Promise2(function (resolve, reject) {
        reject(value);
      });
    };
    Promise2.race = function (values) {
      return new Promise2(function (resolve, reject) {
        values.forEach(function (value) {
          Promise2.resolve(value).then(resolve, reject);
        });
      });
    };
    Promise2.prototype.catch = function (onRejected) {
      return this.then(null, onRejected);
    };
  },
});
var require_asap = __commonJS({
  'node_modules/asap/asap.js'(exports2, module2) {
    'use strict';
    var rawAsap = require_raw(),
      freeTasks = [];
    module2.exports = asap;
    function asap(task) {
      var rawTask;
      (freeTasks.length ? (rawTask = freeTasks.pop()) : (rawTask = new RawTask()),
        (rawTask.task = task),
        (rawTask.domain = process.domain),
        rawAsap(rawTask));
    }
    function RawTask() {
      ((this.task = null), (this.domain = null));
    }
    RawTask.prototype.call = function () {
      this.domain && this.domain.enter();
      var threw = !0;
      try {
        (this.task.call(), (threw = !1), this.domain && this.domain.exit());
      } finally {
        (threw && rawAsap.requestFlush(), (this.task = null), (this.domain = null), freeTasks.push(this));
      }
    };
  },
});
var require_node_extensions = __commonJS({
  'node_modules/promise/lib/node-extensions.js'(exports2, module2) {
    'use strict';
    var Promise2 = require_core(),
      asap = require_asap();
    module2.exports = Promise2;
    Promise2.denodeify = function (fn, argumentCount) {
      return typeof argumentCount == 'number' && argumentCount !== 1 / 0
        ? denodeifyWithCount(fn, argumentCount)
        : denodeifyWithoutCount(fn);
    };
    var callbackFn = 'function (err, res) {if (err) { rj(err); } else { rs(res); }}';
    function denodeifyWithCount(fn, argumentCount) {
      for (var args = [], i = 0; i < argumentCount; i++) args.push('a' + i);
      var body = [
        'return function (' + args.join(',') + ') {',
        'var self = this;',
        'return new Promise(function (rs, rj) {',
        'var res = fn.call(',
        ['self'].concat(args).concat([callbackFn]).join(','),
        ');',
        'if (res &&',
        '(typeof res === "object" || typeof res === "function") &&',
        'typeof res.then === "function"',
        ') {rs(res);}',
        '});',
        '};',
      ].join('');
      return Function(['Promise', 'fn'], body)(Promise2, fn);
    }
    function denodeifyWithoutCount(fn) {
      for (var fnLength = Math.max(fn.length - 1, 3), args = [], i = 0; i < fnLength; i++) args.push('a' + i);
      var body = [
        'return function (' + args.join(',') + ') {',
        'var self = this;',
        'var args;',
        'var argLength = arguments.length;',
        'if (arguments.length > ' + fnLength + ') {',
        'args = new Array(arguments.length + 1);',
        'for (var i = 0; i < arguments.length; i++) {',
        'args[i] = arguments[i];',
        '}',
        '}',
        'return new Promise(function (rs, rj) {',
        'var cb = ' + callbackFn + ';',
        'var res;',
        'switch (argLength) {',
        args
          .concat(['extra'])
          .map(function (_, index) {
            return (
              'case ' +
              index +
              ':res = fn.call(' +
              ['self'].concat(args.slice(0, index)).concat('cb').join(',') +
              ');break;'
            );
          })
          .join(''),
        'default:',
        'args[argLength] = cb;',
        'res = fn.apply(self, args);',
        '}',
        'if (res &&',
        '(typeof res === "object" || typeof res === "function") &&',
        'typeof res.then === "function"',
        ') {rs(res);}',
        '});',
        '};',
      ].join('');
      return Function(['Promise', 'fn'], body)(Promise2, fn);
    }
    Promise2.nodeify = function (fn) {
      return function () {
        var args = Array.prototype.slice.call(arguments),
          callback = typeof args[args.length - 1] == 'function' ? args.pop() : null,
          ctx = this;
        try {
          return fn.apply(this, arguments).nodeify(callback, ctx);
        } catch (ex) {
          if (callback === null || typeof callback > 'u')
            return new Promise2(function (resolve, reject) {
              reject(ex);
            });
          asap(function () {
            callback.call(ctx, ex);
          });
        }
      };
    };
    Promise2.prototype.nodeify = function (callback, ctx) {
      if (typeof callback != 'function') return this;
      this.then(
        function (value) {
          asap(function () {
            callback.call(ctx, null, value);
          });
        },
        function (err) {
          asap(function () {
            callback.call(ctx, err);
          });
        }
      );
    };
  },
});
var require_synchronous = __commonJS({
  'node_modules/promise/lib/synchronous.js'(exports2, module2) {
    'use strict';
    var Promise2 = require_core();
    module2.exports = Promise2;
    Promise2.enableSynchronous = function () {
      ((Promise2.prototype.isPending = function () {
        return this.getState() == 0;
      }),
        (Promise2.prototype.isFulfilled = function () {
          return this.getState() == 1;
        }),
        (Promise2.prototype.isRejected = function () {
          return this.getState() == 2;
        }),
        (Promise2.prototype.getValue = function () {
          if (this._65 === 3) return this._55.getValue();
          if (!this.isFulfilled()) throw new Error('Cannot get a value of an unfulfilled promise.');
          return this._55;
        }),
        (Promise2.prototype.getReason = function () {
          if (this._65 === 3) return this._55.getReason();
          if (!this.isRejected()) throw new Error('Cannot get a rejection reason of a non-rejected promise.');
          return this._55;
        }),
        (Promise2.prototype.getState = function () {
          return this._65 === 3 ? this._55.getState() : this._65 === -1 || this._65 === -2 ? 0 : this._65;
        }));
    };
    Promise2.disableSynchronous = function () {
      ((Promise2.prototype.isPending = void 0),
        (Promise2.prototype.isFulfilled = void 0),
        (Promise2.prototype.isRejected = void 0),
        (Promise2.prototype.getValue = void 0),
        (Promise2.prototype.getReason = void 0),
        (Promise2.prototype.getState = void 0));
    };
  },
});
var require_lib = __commonJS({
  'node_modules/promise/lib/index.js'(exports2, module2) {
    'use strict';
    module2.exports = require_core();
    require_done();
    require_finally();
    require_es6_extensions();
    require_node_extensions();
    require_synchronous();
  },
});
var require_promise = __commonJS({
  'node_modules/promise/index.js'(exports2, module2) {
    'use strict';
    module2.exports = require_lib();
  },
});
var require_inherits_browser3 = __commonJS({
  'node_modules/drop-stream/node_modules/readable-stream/node_modules/inherits/inherits_browser.js'(exports2, module2) {
    'use strict';
    typeof Object.create == 'function'
      ? (module2.exports = function (ctor, superCtor) {
          superCtor &&
            ((ctor.super_ = superCtor),
            (ctor.prototype = Object.create(superCtor.prototype, {
              constructor: { value: ctor, enumerable: !1, writable: !0, configurable: !0 },
            })));
        })
      : (module2.exports = function (ctor, superCtor) {
          if (superCtor) {
            ctor.super_ = superCtor;
            var TempCtor = function () {};
            ((TempCtor.prototype = superCtor.prototype),
              (ctor.prototype = new TempCtor()),
              (ctor.prototype.constructor = ctor));
          }
        });
  },
});
var require_inherits3 = __commonJS({
  'node_modules/drop-stream/node_modules/readable-stream/node_modules/inherits/inherits.js'(exports2, module2) {
    'use strict';
    try {
      if (((util = require('util')), typeof util.inherits != 'function')) throw '';
      module2.exports = util.inherits;
    } catch {
      module2.exports = require_inherits_browser3();
    }
    var util;
  },
});
var require_string_decoder3 = __commonJS({
  'node_modules/drop-stream/node_modules/readable-stream/node_modules/string_decoder/index.js'(exports2) {
    'use strict';
    var Buffer2 = require('buffer').Buffer,
      isBufferEncoding =
        Buffer2.isEncoding ||
        function (encoding) {
          switch (encoding && encoding.toLowerCase()) {
            case 'hex':
            case 'utf8':
            case 'utf-8':
            case 'ascii':
            case 'binary':
            case 'base64':
            case 'ucs2':
            case 'ucs-2':
            case 'utf16le':
            case 'utf-16le':
            case 'raw':
              return !0;
            default:
              return !1;
          }
        };
    function assertEncoding(encoding) {
      if (encoding && !isBufferEncoding(encoding)) throw new Error('Unknown encoding: ' + encoding);
    }
    var StringDecoder = (exports2.StringDecoder = function (encoding) {
      switch (
        ((this.encoding = (encoding || 'utf8').toLowerCase().replace(/[-_]/, '')),
        assertEncoding(encoding),
        this.encoding)
      ) {
        case 'utf8':
          this.surrogateSize = 3;
          break;
        case 'ucs2':
        case 'utf16le':
          ((this.surrogateSize = 2), (this.detectIncompleteChar = utf16DetectIncompleteChar));
          break;
        case 'base64':
          ((this.surrogateSize = 3), (this.detectIncompleteChar = base64DetectIncompleteChar));
          break;
        default:
          this.write = passThroughWrite;
          return;
      }
      ((this.charBuffer = Buffer2.allocUnsafe(6)), (this.charReceived = 0), (this.charLength = 0));
    });
    StringDecoder.prototype.write = function (buffer) {
      for (var charStr = ''; this.charLength; ) {
        var available =
          buffer.length >= this.charLength - this.charReceived ? this.charLength - this.charReceived : buffer.length;
        if (
          (buffer.copy(this.charBuffer, this.charReceived, 0, available),
          (this.charReceived += available),
          this.charReceived < this.charLength)
        )
          return '';
        ((buffer = buffer.slice(available, buffer.length)),
          (charStr = this.charBuffer.slice(0, this.charLength).toString(this.encoding)));
        var charCode = charStr.charCodeAt(charStr.length - 1);
        if (charCode >= 55296 && charCode <= 56319) {
          ((this.charLength += this.surrogateSize), (charStr = ''));
          continue;
        }
        if (((this.charReceived = this.charLength = 0), buffer.length === 0)) return charStr;
        break;
      }
      this.detectIncompleteChar(buffer);
      var end = buffer.length;
      (this.charLength &&
        (buffer.copy(this.charBuffer, 0, buffer.length - this.charReceived, end), (end -= this.charReceived)),
        (charStr += buffer.toString(this.encoding, 0, end)));
      var end = charStr.length - 1,
        charCode = charStr.charCodeAt(end);
      if (charCode >= 55296 && charCode <= 56319) {
        var size = this.surrogateSize;
        return (
          (this.charLength += size),
          (this.charReceived += size),
          this.charBuffer.copy(this.charBuffer, size, 0, size),
          buffer.copy(this.charBuffer, 0, 0, size),
          charStr.substring(0, end)
        );
      }
      return charStr;
    };
    StringDecoder.prototype.detectIncompleteChar = function (buffer) {
      for (var i = buffer.length >= 3 ? 3 : buffer.length; i > 0; i--) {
        var c = buffer[buffer.length - i];
        if (i == 1 && c >> 5 == 6) {
          this.charLength = 2;
          break;
        }
        if (i <= 2 && c >> 4 == 14) {
          this.charLength = 3;
          break;
        }
        if (i <= 3 && c >> 3 == 30) {
          this.charLength = 4;
          break;
        }
      }
      this.charReceived = i;
    };
    StringDecoder.prototype.end = function (buffer) {
      var res = '';
      if ((buffer && buffer.length && (res = this.write(buffer)), this.charReceived)) {
        var cr = this.charReceived,
          buf = this.charBuffer,
          enc = this.encoding;
        res += buf.slice(0, cr).toString(enc);
      }
      return res;
    };
    function passThroughWrite(buffer) {
      return buffer.toString(this.encoding);
    }
    function utf16DetectIncompleteChar(buffer) {
      ((this.charReceived = buffer.length % 2), (this.charLength = this.charReceived ? 2 : 0));
    }
    function base64DetectIncompleteChar(buffer) {
      ((this.charReceived = buffer.length % 3), (this.charLength = this.charReceived ? 3 : 0));
    }
  },
});
var require_stream_readable3 = __commonJS({
  'node_modules/drop-stream/node_modules/readable-stream/lib/_stream_readable.js'(exports2, module2) {
    'use strict';
    module2.exports = Readable;
    var isArray = require_isarray(),
      Buffer2 = require('buffer').Buffer;
    Readable.ReadableState = ReadableState;
    var EE = require('events').EventEmitter;
    EE.listenerCount ||
      (EE.listenerCount = function (emitter, type) {
        return emitter.listeners(type).length;
      });
    var Stream = require('stream'),
      util = require_util();
    util.inherits = require_inherits3();
    var StringDecoder;
    util.inherits(Readable, Stream);
    function ReadableState(options, stream) {
      options = options || {};
      var hwm = options.highWaterMark;
      ((this.highWaterMark = hwm || hwm === 0 ? hwm : 16 * 1024),
        (this.highWaterMark = ~~this.highWaterMark),
        (this.buffer = []),
        (this.length = 0),
        (this.pipes = null),
        (this.pipesCount = 0),
        (this.flowing = !1),
        (this.ended = !1),
        (this.endEmitted = !1),
        (this.reading = !1),
        (this.calledRead = !1),
        (this.sync = !0),
        (this.needReadable = !1),
        (this.emittedReadable = !1),
        (this.readableListening = !1),
        (this.objectMode = !!options.objectMode),
        (this.defaultEncoding = options.defaultEncoding || 'utf8'),
        (this.ranOut = !1),
        (this.awaitDrain = 0),
        (this.readingMore = !1),
        (this.decoder = null),
        (this.encoding = null),
        options.encoding &&
          (StringDecoder || (StringDecoder = require_string_decoder3().StringDecoder),
          (this.decoder = new StringDecoder(options.encoding)),
          (this.encoding = options.encoding)));
    }
    function Readable(options) {
      if (!(this instanceof Readable)) return new Readable(options);
      ((this._readableState = new ReadableState(options, this)), (this.readable = !0), Stream.call(this));
    }
    Readable.prototype.push = function (chunk, encoding) {
      var state = this._readableState;
      return (
        typeof chunk == 'string' &&
          !state.objectMode &&
          ((encoding = encoding || state.defaultEncoding),
          encoding !== state.encoding && ((chunk = Buffer2.from(chunk, encoding)), (encoding = ''))),
        readableAddChunk(this, state, chunk, encoding, !1)
      );
    };
    Readable.prototype.unshift = function (chunk) {
      var state = this._readableState;
      return readableAddChunk(this, state, chunk, '', !0);
    };
    function readableAddChunk(stream, state, chunk, encoding, addToFront) {
      var er = chunkInvalid(state, chunk);
      if (er) stream.emit('error', er);
      else if (chunk == null) ((state.reading = !1), state.ended || onEofChunk(stream, state));
      else if (state.objectMode || (chunk && chunk.length > 0))
        if (state.ended && !addToFront) {
          var e = new Error('stream.push() after EOF');
          stream.emit('error', e);
        } else if (state.endEmitted && addToFront) {
          var e = new Error('stream.unshift() after end event');
          stream.emit('error', e);
        } else
          (state.decoder && !addToFront && !encoding && (chunk = state.decoder.write(chunk)),
            (state.length += state.objectMode ? 1 : chunk.length),
            addToFront ? state.buffer.unshift(chunk) : ((state.reading = !1), state.buffer.push(chunk)),
            state.needReadable && emitReadable(stream),
            maybeReadMore(stream, state));
      else addToFront || (state.reading = !1);
      return needMoreData(state);
    }
    function needMoreData(state) {
      return !state.ended && (state.needReadable || state.length < state.highWaterMark || state.length === 0);
    }
    Readable.prototype.setEncoding = function (enc) {
      (StringDecoder || (StringDecoder = require_string_decoder3().StringDecoder),
        (this._readableState.decoder = new StringDecoder(enc)),
        (this._readableState.encoding = enc));
    };
    var MAX_HWM = 8388608;
    function roundUpToNextPowerOf2(n) {
      if (n >= MAX_HWM) n = MAX_HWM;
      else {
        n--;
        for (var p = 1; p < 32; p <<= 1) n |= n >> p;
        n++;
      }
      return n;
    }
    function howMuchToRead(n, state) {
      return state.length === 0 && state.ended
        ? 0
        : state.objectMode
          ? n === 0
            ? 0
            : 1
          : n === null || isNaN(n)
            ? state.flowing && state.buffer.length
              ? state.buffer[0].length
              : state.length
            : n <= 0
              ? 0
              : (n > state.highWaterMark && (state.highWaterMark = roundUpToNextPowerOf2(n)),
                n > state.length ? (state.ended ? state.length : ((state.needReadable = !0), 0)) : n);
    }
    Readable.prototype.read = function (n) {
      var state = this._readableState;
      state.calledRead = !0;
      var nOrig = n,
        ret;
      if (
        ((typeof n != 'number' || n > 0) && (state.emittedReadable = !1),
        n === 0 && state.needReadable && (state.length >= state.highWaterMark || state.ended))
      )
        return (emitReadable(this), null);
      if (((n = howMuchToRead(n, state)), n === 0 && state.ended))
        return (
          (ret = null),
          state.length > 0 && state.decoder && ((ret = fromList(n, state)), (state.length -= ret.length)),
          state.length === 0 && endReadable(this),
          ret
        );
      var doRead = state.needReadable;
      return (
        state.length - n <= state.highWaterMark && (doRead = !0),
        (state.ended || state.reading) && (doRead = !1),
        doRead &&
          ((state.reading = !0),
          (state.sync = !0),
          state.length === 0 && (state.needReadable = !0),
          this._read(state.highWaterMark),
          (state.sync = !1)),
        doRead && !state.reading && (n = howMuchToRead(nOrig, state)),
        n > 0 ? (ret = fromList(n, state)) : (ret = null),
        ret === null && ((state.needReadable = !0), (n = 0)),
        (state.length -= n),
        state.length === 0 && !state.ended && (state.needReadable = !0),
        state.ended && !state.endEmitted && state.length === 0 && endReadable(this),
        ret
      );
    };
    function chunkInvalid(state, chunk) {
      var er = null;
      return (
        !Buffer2.isBuffer(chunk) &&
          typeof chunk != 'string' &&
          chunk !== null &&
          chunk !== void 0 &&
          !state.objectMode &&
          (er = new TypeError('Invalid non-string/buffer chunk')),
        er
      );
    }
    function onEofChunk(stream, state) {
      if (state.decoder && !state.ended) {
        var chunk = state.decoder.end();
        chunk && chunk.length && (state.buffer.push(chunk), (state.length += state.objectMode ? 1 : chunk.length));
      }
      ((state.ended = !0), state.length > 0 ? emitReadable(stream) : endReadable(stream));
    }
    function emitReadable(stream) {
      var state = stream._readableState;
      ((state.needReadable = !1),
        !state.emittedReadable &&
          ((state.emittedReadable = !0),
          state.sync
            ? process.nextTick(function () {
                emitReadable_(stream);
              })
            : emitReadable_(stream)));
    }
    function emitReadable_(stream) {
      stream.emit('readable');
    }
    function maybeReadMore(stream, state) {
      state.readingMore ||
        ((state.readingMore = !0),
        process.nextTick(function () {
          maybeReadMore_(stream, state);
        }));
    }
    function maybeReadMore_(stream, state) {
      for (
        var len = state.length;
        !state.reading &&
        !state.flowing &&
        !state.ended &&
        state.length < state.highWaterMark &&
        (stream.read(0), len !== state.length);
      )
        len = state.length;
      state.readingMore = !1;
    }
    Readable.prototype._read = function (n) {
      this.emit('error', new Error('not implemented'));
    };
    Readable.prototype.pipe = function (dest2, pipeOpts) {
      var src = this,
        state = this._readableState;
      switch (state.pipesCount) {
        case 0:
          state.pipes = dest2;
          break;
        case 1:
          state.pipes = [state.pipes, dest2];
          break;
        default:
          state.pipes.push(dest2);
          break;
      }
      state.pipesCount += 1;
      var doEnd = (!pipeOpts || pipeOpts.end !== !1) && dest2 !== process.stdout && dest2 !== process.stderr,
        endFn = doEnd ? onend : cleanup;
      (state.endEmitted ? process.nextTick(endFn) : src.once('end', endFn), dest2.on('unpipe', onunpipe));
      function onunpipe(readable) {
        readable === src && cleanup();
      }
      function onend() {
        dest2.end();
      }
      var ondrain = pipeOnDrain(src);
      dest2.on('drain', ondrain);
      function cleanup() {
        (dest2.removeListener('close', onclose),
          dest2.removeListener('finish', onfinish),
          dest2.removeListener('drain', ondrain),
          dest2.removeListener('error', onerror),
          dest2.removeListener('unpipe', onunpipe),
          src.removeListener('end', onend),
          src.removeListener('end', cleanup),
          (!dest2._writableState || dest2._writableState.needDrain) && ondrain());
      }
      function onerror(er) {
        (unpipe(),
          dest2.removeListener('error', onerror),
          EE.listenerCount(dest2, 'error') === 0 && dest2.emit('error', er));
      }
      !dest2._events || !dest2._events.error
        ? dest2.on('error', onerror)
        : isArray(dest2._events.error)
          ? dest2._events.error.unshift(onerror)
          : (dest2._events.error = [onerror, dest2._events.error]);
      function onclose() {
        (dest2.removeListener('finish', onfinish), unpipe());
      }
      dest2.once('close', onclose);
      function onfinish() {
        (dest2.removeListener('close', onclose), unpipe());
      }
      dest2.once('finish', onfinish);
      function unpipe() {
        src.unpipe(dest2);
      }
      return (
        dest2.emit('pipe', src),
        state.flowing ||
          (this.on('readable', pipeOnReadable),
          (state.flowing = !0),
          process.nextTick(function () {
            flow(src);
          })),
        dest2
      );
    };
    function pipeOnDrain(src) {
      return function () {
        var dest2 = this,
          state = src._readableState;
        (state.awaitDrain--, state.awaitDrain === 0 && flow(src));
      };
    }
    function flow(src) {
      var state = src._readableState,
        chunk;
      state.awaitDrain = 0;
      function write(dest2, i, list) {
        var written = dest2.write(chunk);
        written === !1 && state.awaitDrain++;
      }
      for (; state.pipesCount && (chunk = src.read()) !== null; )
        if (
          (state.pipesCount === 1 ? write(state.pipes, 0, null) : forEach(state.pipes, write),
          src.emit('data', chunk),
          state.awaitDrain > 0)
        )
          return;
      if (state.pipesCount === 0) {
        ((state.flowing = !1), EE.listenerCount(src, 'data') > 0 && emitDataEvents(src));
        return;
      }
      state.ranOut = !0;
    }
    function pipeOnReadable() {
      this._readableState.ranOut && ((this._readableState.ranOut = !1), flow(this));
    }
    Readable.prototype.unpipe = function (dest2) {
      var state = this._readableState;
      if (state.pipesCount === 0) return this;
      if (state.pipesCount === 1)
        return dest2 && dest2 !== state.pipes
          ? this
          : (dest2 || (dest2 = state.pipes),
            (state.pipes = null),
            (state.pipesCount = 0),
            this.removeListener('readable', pipeOnReadable),
            (state.flowing = !1),
            dest2 && dest2.emit('unpipe', this),
            this);
      if (!dest2) {
        var dests = state.pipes,
          len = state.pipesCount;
        ((state.pipes = null),
          (state.pipesCount = 0),
          this.removeListener('readable', pipeOnReadable),
          (state.flowing = !1));
        for (var i = 0; i < len; i++) dests[i].emit('unpipe', this);
        return this;
      }
      var i = indexOf(state.pipes, dest2);
      return i === -1
        ? this
        : (state.pipes.splice(i, 1),
          (state.pipesCount -= 1),
          state.pipesCount === 1 && (state.pipes = state.pipes[0]),
          dest2.emit('unpipe', this),
          this);
    };
    Readable.prototype.on = function (ev, fn) {
      var res = Stream.prototype.on.call(this, ev, fn);
      if ((ev === 'data' && !this._readableState.flowing && emitDataEvents(this), ev === 'readable' && this.readable)) {
        var state = this._readableState;
        state.readableListening ||
          ((state.readableListening = !0),
          (state.emittedReadable = !1),
          (state.needReadable = !0),
          state.reading ? state.length && emitReadable(this, state) : this.read(0));
      }
      return res;
    };
    Readable.prototype.addListener = Readable.prototype.on;
    Readable.prototype.resume = function () {
      (emitDataEvents(this), this.read(0), this.emit('resume'));
    };
    Readable.prototype.pause = function () {
      (emitDataEvents(this, !0), this.emit('pause'));
    };
    function emitDataEvents(stream, startPaused) {
      var state = stream._readableState;
      if (state.flowing) throw new Error('Cannot switch to old mode now.');
      var paused = startPaused || !1,
        readable = !1;
      ((stream.readable = !0),
        (stream.pipe = Stream.prototype.pipe),
        (stream.on = stream.addListener = Stream.prototype.on),
        stream.on('readable', function () {
          readable = !0;
          for (var c; !paused && (c = stream.read()) !== null; ) stream.emit('data', c);
          c === null && ((readable = !1), (stream._readableState.needReadable = !0));
        }),
        (stream.pause = function () {
          ((paused = !0), this.emit('pause'));
        }),
        (stream.resume = function () {
          ((paused = !1),
            readable
              ? process.nextTick(function () {
                  stream.emit('readable');
                })
              : this.read(0),
            this.emit('resume'));
        }),
        stream.emit('readable'));
    }
    Readable.prototype.wrap = function (stream) {
      var state = this._readableState,
        paused = !1,
        self2 = this;
      (stream.on('end', function () {
        if (state.decoder && !state.ended) {
          var chunk = state.decoder.end();
          chunk && chunk.length && self2.push(chunk);
        }
        self2.push(null);
      }),
        stream.on('data', function (chunk) {
          if (
            (state.decoder && (chunk = state.decoder.write(chunk)),
            !(state.objectMode && chunk == null) && !(!state.objectMode && (!chunk || !chunk.length)))
          ) {
            var ret = self2.push(chunk);
            ret || ((paused = !0), stream.pause());
          }
        }));
      for (var i in stream)
        typeof stream[i] == 'function' &&
          typeof this[i] > 'u' &&
          (this[i] = (function (method) {
            return function () {
              return stream[method].apply(stream, arguments);
            };
          })(i));
      var events = ['error', 'close', 'destroy', 'pause', 'resume'];
      return (
        forEach(events, function (ev) {
          stream.on(ev, self2.emit.bind(self2, ev));
        }),
        (self2._read = function (n) {
          paused && ((paused = !1), stream.resume());
        }),
        self2
      );
    };
    Readable._fromList = fromList;
    function fromList(n, state) {
      var list = state.buffer,
        length = state.length,
        stringMode = !!state.decoder,
        objectMode = !!state.objectMode,
        ret;
      if (list.length === 0) return null;
      if (length === 0) ret = null;
      else if (objectMode) ret = list.shift();
      else if (!n || n >= length)
        (stringMode ? (ret = list.join('')) : (ret = Buffer2.concat(list, length)), (list.length = 0));
      else if (n < list[0].length) {
        var buf = list[0];
        ((ret = buf.slice(0, n)), (list[0] = buf.slice(n)));
      } else if (n === list[0].length) ret = list.shift();
      else {
        stringMode ? (ret = '') : (ret = Buffer2.allocUnsafe(n));
        for (var c = 0, i = 0, l = list.length; i < l && c < n; i++) {
          var buf = list[0],
            cpy = Math.min(n - c, buf.length);
          (stringMode ? (ret += buf.slice(0, cpy)) : buf.copy(ret, c, 0, cpy),
            cpy < buf.length ? (list[0] = buf.slice(cpy)) : list.shift(),
            (c += cpy));
        }
      }
      return ret;
    }
    function endReadable(stream) {
      var state = stream._readableState;
      if (state.length > 0) throw new Error('endReadable called on non-empty stream');
      !state.endEmitted &&
        state.calledRead &&
        ((state.ended = !0),
        process.nextTick(function () {
          !state.endEmitted &&
            state.length === 0 &&
            ((state.endEmitted = !0), (stream.readable = !1), stream.emit('end'));
        }));
    }
    function forEach(xs, f) {
      for (var i = 0, l = xs.length; i < l; i++) f(xs[i], i);
    }
    function indexOf(xs, x) {
      for (var i = 0, l = xs.length; i < l; i++) if (xs[i] === x) return i;
      return -1;
    }
  },
});
var require_stream_writable3 = __commonJS({
  'node_modules/drop-stream/node_modules/readable-stream/lib/_stream_writable.js'(exports2, module2) {
    'use strict';
    module2.exports = Writable;
    var Buffer2 = require('buffer').Buffer;
    Writable.WritableState = WritableState;
    var util = require_util();
    util.inherits = require_inherits3();
    var Stream = require('stream');
    util.inherits(Writable, Stream);
    function WriteReq(chunk, encoding, cb) {
      ((this.chunk = chunk), (this.encoding = encoding), (this.callback = cb));
    }
    function WritableState(options, stream) {
      options = options || {};
      var hwm = options.highWaterMark;
      ((this.highWaterMark = hwm || hwm === 0 ? hwm : 16 * 1024),
        (this.objectMode = !!options.objectMode),
        (this.highWaterMark = ~~this.highWaterMark),
        (this.needDrain = !1),
        (this.ending = !1),
        (this.ended = !1),
        (this.finished = !1));
      var noDecode = options.decodeStrings === !1;
      ((this.decodeStrings = !noDecode),
        (this.defaultEncoding = options.defaultEncoding || 'utf8'),
        (this.length = 0),
        (this.writing = !1),
        (this.sync = !0),
        (this.bufferProcessing = !1),
        (this.onwrite = function (er) {
          onwrite(stream, er);
        }),
        (this.writecb = null),
        (this.writelen = 0),
        (this.buffer = []),
        (this.errorEmitted = !1));
    }
    function Writable(options) {
      var Duplex = require_stream_duplex3();
      if (!(this instanceof Writable) && !(this instanceof Duplex)) return new Writable(options);
      ((this._writableState = new WritableState(options, this)), (this.writable = !0), Stream.call(this));
    }
    Writable.prototype.pipe = function () {
      this.emit('error', new Error('Cannot pipe. Not readable.'));
    };
    function writeAfterEnd(stream, state, cb) {
      var er = new Error('write after end');
      (stream.emit('error', er),
        process.nextTick(function () {
          cb(er);
        }));
    }
    function validChunk(stream, state, chunk, cb) {
      var valid = !0;
      if (
        !Buffer2.isBuffer(chunk) &&
        typeof chunk != 'string' &&
        chunk !== null &&
        chunk !== void 0 &&
        !state.objectMode
      ) {
        var er = new TypeError('Invalid non-string/buffer chunk');
        (stream.emit('error', er),
          process.nextTick(function () {
            cb(er);
          }),
          (valid = !1));
      }
      return valid;
    }
    Writable.prototype.write = function (chunk, encoding, cb) {
      var state = this._writableState,
        ret = !1;
      return (
        typeof encoding == 'function' && ((cb = encoding), (encoding = null)),
        Buffer2.isBuffer(chunk) ? (encoding = 'buffer') : encoding || (encoding = state.defaultEncoding),
        typeof cb != 'function' && (cb = function () {}),
        state.ended
          ? writeAfterEnd(this, state, cb)
          : validChunk(this, state, chunk, cb) && (ret = writeOrBuffer(this, state, chunk, encoding, cb)),
        ret
      );
    };
    function decodeChunk(state, chunk, encoding) {
      return (
        !state.objectMode &&
          state.decodeStrings !== !1 &&
          typeof chunk == 'string' &&
          (chunk = Buffer2.from(chunk, encoding)),
        chunk
      );
    }
    function writeOrBuffer(stream, state, chunk, encoding, cb) {
      ((chunk = decodeChunk(state, chunk, encoding)), Buffer2.isBuffer(chunk) && (encoding = 'buffer'));
      var len = state.objectMode ? 1 : chunk.length;
      state.length += len;
      var ret = state.length < state.highWaterMark;
      return (
        ret || (state.needDrain = !0),
        state.writing
          ? state.buffer.push(new WriteReq(chunk, encoding, cb))
          : doWrite(stream, state, len, chunk, encoding, cb),
        ret
      );
    }
    function doWrite(stream, state, len, chunk, encoding, cb) {
      ((state.writelen = len),
        (state.writecb = cb),
        (state.writing = !0),
        (state.sync = !0),
        stream._write(chunk, encoding, state.onwrite),
        (state.sync = !1));
    }
    function onwriteError(stream, state, sync, er, cb) {
      (sync
        ? process.nextTick(function () {
            cb(er);
          })
        : cb(er),
        (stream._writableState.errorEmitted = !0),
        stream.emit('error', er));
    }
    function onwriteStateUpdate(state) {
      ((state.writing = !1), (state.writecb = null), (state.length -= state.writelen), (state.writelen = 0));
    }
    function onwrite(stream, er) {
      var state = stream._writableState,
        sync = state.sync,
        cb = state.writecb;
      if ((onwriteStateUpdate(state), er)) onwriteError(stream, state, sync, er, cb);
      else {
        var finished = needFinish(stream, state);
        (!finished && !state.bufferProcessing && state.buffer.length && clearBuffer(stream, state),
          sync
            ? process.nextTick(function () {
                afterWrite(stream, state, finished, cb);
              })
            : afterWrite(stream, state, finished, cb));
      }
    }
    function afterWrite(stream, state, finished, cb) {
      (finished || onwriteDrain(stream, state), cb(), finished && finishMaybe(stream, state));
    }
    function onwriteDrain(stream, state) {
      state.length === 0 && state.needDrain && ((state.needDrain = !1), stream.emit('drain'));
    }
    function clearBuffer(stream, state) {
      state.bufferProcessing = !0;
      for (var c = 0; c < state.buffer.length; c++) {
        var entry = state.buffer[c],
          chunk = entry.chunk,
          encoding = entry.encoding,
          cb = entry.callback,
          len = state.objectMode ? 1 : chunk.length;
        if ((doWrite(stream, state, len, chunk, encoding, cb), state.writing)) {
          c++;
          break;
        }
      }
      ((state.bufferProcessing = !1),
        c < state.buffer.length ? (state.buffer = state.buffer.slice(c)) : (state.buffer.length = 0));
    }
    Writable.prototype._write = function (chunk, encoding, cb) {
      cb(new Error('not implemented'));
    };
    Writable.prototype.end = function (chunk, encoding, cb) {
      var state = this._writableState;
      (typeof chunk == 'function'
        ? ((cb = chunk), (chunk = null), (encoding = null))
        : typeof encoding == 'function' && ((cb = encoding), (encoding = null)),
        typeof chunk < 'u' && chunk !== null && this.write(chunk, encoding),
        !state.ending && !state.finished && endWritable(this, state, cb));
    };
    function needFinish(stream, state) {
      return state.ending && state.length === 0 && !state.finished && !state.writing;
    }
    function finishMaybe(stream, state) {
      var need = needFinish(stream, state);
      return (need && ((state.finished = !0), stream.emit('finish')), need);
    }
    function endWritable(stream, state, cb) {
      ((state.ending = !0),
        finishMaybe(stream, state),
        cb && (state.finished ? process.nextTick(cb) : stream.once('finish', cb)),
        (state.ended = !0));
    }
  },
});
var require_stream_duplex3 = __commonJS({
  'node_modules/drop-stream/node_modules/readable-stream/lib/_stream_duplex.js'(exports2, module2) {
    'use strict';
    module2.exports = Duplex;
    var objectKeys =
        Object.keys ||
        function (obj) {
          var keys = [];
          for (var key in obj) keys.push(key);
          return keys;
        },
      util = require_util();
    util.inherits = require_inherits3();
    var Readable = require_stream_readable3(),
      Writable = require_stream_writable3();
    util.inherits(Duplex, Readable);
    forEach(objectKeys(Writable.prototype), function (method) {
      Duplex.prototype[method] || (Duplex.prototype[method] = Writable.prototype[method]);
    });
    function Duplex(options) {
      if (!(this instanceof Duplex)) return new Duplex(options);
      (Readable.call(this, options),
        Writable.call(this, options),
        options && options.readable === !1 && (this.readable = !1),
        options && options.writable === !1 && (this.writable = !1),
        (this.allowHalfOpen = !0),
        options && options.allowHalfOpen === !1 && (this.allowHalfOpen = !1),
        this.once('end', onend));
    }
    function onend() {
      this.allowHalfOpen || this._writableState.ended || process.nextTick(this.end.bind(this));
    }
    function forEach(xs, f) {
      for (var i = 0, l = xs.length; i < l; i++) f(xs[i], i);
    }
  },
});
var require_stream_transform3 = __commonJS({
  'node_modules/drop-stream/node_modules/readable-stream/lib/_stream_transform.js'(exports2, module2) {
    'use strict';
    module2.exports = Transform;
    var Duplex = require_stream_duplex3(),
      util = require_util();
    util.inherits = require_inherits3();
    util.inherits(Transform, Duplex);
    function TransformState(options, stream) {
      ((this.afterTransform = function (er, data) {
        return afterTransform(stream, er, data);
      }),
        (this.needTransform = !1),
        (this.transforming = !1),
        (this.writecb = null),
        (this.writechunk = null));
    }
    function afterTransform(stream, er, data) {
      var ts = stream._transformState;
      ts.transforming = !1;
      var cb = ts.writecb;
      if (!cb) return stream.emit('error', new Error('no writecb in Transform class'));
      ((ts.writechunk = null), (ts.writecb = null), data != null && stream.push(data), cb && cb(er));
      var rs = stream._readableState;
      ((rs.reading = !1), (rs.needReadable || rs.length < rs.highWaterMark) && stream._read(rs.highWaterMark));
    }
    function Transform(options) {
      if (!(this instanceof Transform)) return new Transform(options);
      Duplex.call(this, options);
      var ts = (this._transformState = new TransformState(options, this)),
        stream = this;
      ((this._readableState.needReadable = !0),
        (this._readableState.sync = !1),
        this.once('finish', function () {
          typeof this._flush == 'function'
            ? this._flush(function (er) {
                done(stream, er);
              })
            : done(stream);
        }));
    }
    Transform.prototype.push = function (chunk, encoding) {
      return ((this._transformState.needTransform = !1), Duplex.prototype.push.call(this, chunk, encoding));
    };
    Transform.prototype._transform = function (chunk, encoding, cb) {
      throw new Error('not implemented');
    };
    Transform.prototype._write = function (chunk, encoding, cb) {
      var ts = this._transformState;
      if (((ts.writecb = cb), (ts.writechunk = chunk), (ts.writeencoding = encoding), !ts.transforming)) {
        var rs = this._readableState;
        (ts.needTransform || rs.needReadable || rs.length < rs.highWaterMark) && this._read(rs.highWaterMark);
      }
    };
    Transform.prototype._read = function (n) {
      var ts = this._transformState;
      ts.writechunk !== null && ts.writecb && !ts.transforming
        ? ((ts.transforming = !0), this._transform(ts.writechunk, ts.writeencoding, ts.afterTransform))
        : (ts.needTransform = !0);
    };
    function done(stream, er) {
      if (er) return stream.emit('error', er);
      var ws = stream._writableState,
        rs = stream._readableState,
        ts = stream._transformState;
      if (ws.length) throw new Error('calling transform done when ws.length != 0');
      if (ts.transforming) throw new Error('calling transform done when still transforming');
      return stream.push(null);
    }
  },
});
var require_transform = __commonJS({
  'node_modules/drop-stream/node_modules/readable-stream/transform.js'(exports2, module2) {
    'use strict';
    module2.exports = require_stream_transform3();
  },
});
var require_drop_stream = __commonJS({
  'node_modules/drop-stream/index.js'(exports2, module2) {
    'use strict';
    var Transform = require_transform(),
      inherits = require('util').inherits;
    function DropStream(options) {
      if (!(this instanceof DropStream)) return new DropStream(options);
      Transform.call(this, options);
    }
    inherits(DropStream, Transform);
    DropStream.prototype._transform = function (chunk, encoding, done) {
      done();
    };
    DropStream.obj = function (options) {
      return ((options = options || {}), (options.objectMode = !0), new DropStream(options));
    };
    module2.exports = DropStream;
  },
});
var require_utils = __commonJS({
  'node_modules/mumble-client/lib/utils.js'(exports2) {
    'use strict';
    Object.defineProperty(exports2, '__esModule', { value: !0 });
    exports2.getOSName = getOSName;
    exports2.getOSVersion = getOSVersion;
    function getOSName() {
      return process.browser ? 'Browser' : 'Node.js';
    }
    function getOSVersion() {
      return process.browser ? navigator.userAgent : process.version;
    }
  },
});
var require_remove_value = __commonJS({
  'node_modules/remove-value/index.js'(exports2, module2) {
    'use strict';
    module2.exports = function (array, value, count) {
      Array.isArray(this) && ((count = value), (value = array), (array = this));
      for (var index, i = 0; (!count || i++ < count) && ~(index = array.indexOf(value)); ) array.splice(index, 1);
      return array;
    };
  },
});
var require_rtimer = __commonJS({
  'node_modules/rtimer/index.js'(exports2, module2) {
    'use strict';
    function Timer(callback, delay) {
      if (!(this instanceof Timer)) return new Timer(callback, delay);
      ((this._timeout = null), (this.delay = delay), (this.callback = callback));
    }
    module2.exports = Timer;
    Timer.prototype.clear = function () {
      return (this._timeout && (clearTimeout(this._timeout), (this._timeout = null)), this);
    };
    Timer.prototype.set = function () {
      return (this.clear(), (this._timeout = setTimeout(this.callback, this.delay)), this);
    };
  },
});
var require_user = __commonJS({
  'node_modules/mumble-client/lib/user.js'(exports2) {
    'use strict';
    Object.defineProperty(exports2, '__esModule', { value: !0 });
    var _createClass = (function () {
        function defineProperties(target, props) {
          for (var i = 0; i < props.length; i++) {
            var descriptor = props[i];
            ((descriptor.enumerable = descriptor.enumerable || !1),
              (descriptor.configurable = !0),
              'value' in descriptor && (descriptor.writable = !0),
              Object.defineProperty(target, descriptor.key, descriptor));
          }
        }
        return function (Constructor, protoProps, staticProps) {
          return (
            protoProps && defineProperties(Constructor.prototype, protoProps),
            staticProps && defineProperties(Constructor, staticProps),
            Constructor
          );
        };
      })(),
      _events = require('events'),
      _dropStream = require_drop_stream(),
      _dropStream2 = _interopRequireDefault(_dropStream),
      _removeValue = require_remove_value(),
      _removeValue2 = _interopRequireDefault(_removeValue),
      _rtimer = require_rtimer(),
      _rtimer2 = _interopRequireDefault(_rtimer);
    function _interopRequireDefault(obj) {
      return obj && obj.__esModule ? obj : { default: obj };
    }
    function _classCallCheck(instance, Constructor) {
      if (!(instance instanceof Constructor)) throw new TypeError('Cannot call a class as a function');
    }
    function _possibleConstructorReturn(self2, call) {
      if (!self2) throw new ReferenceError("this hasn't been initialised - super() hasn't been called");
      return call && (typeof call == 'object' || typeof call == 'function') ? call : self2;
    }
    function _inherits(subClass, superClass) {
      if (typeof superClass != 'function' && superClass !== null)
        throw new TypeError('Super expression must either be null or a function, not ' + typeof superClass);
      ((subClass.prototype = Object.create(superClass && superClass.prototype, {
        constructor: { value: subClass, enumerable: !1, writable: !0, configurable: !0 },
      })),
        superClass &&
          (Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : (subClass.__proto__ = superClass)));
    }
    var User = (function (_EventEmitter) {
      _inherits(User2, _EventEmitter);
      function User2(client, id) {
        _classCallCheck(this, User2);
        var _this = _possibleConstructorReturn(this, (User2.__proto__ || Object.getPrototypeOf(User2)).call(this));
        return (
          (_this._client = client),
          (_this._id = id),
          (_this._haveRequestedTexture = !1),
          (_this._haveRequestedComment = !1),
          _this
        );
      }
      return (
        _createClass(User2, [
          {
            key: '_update',
            value: function (msg) {
              var changes = {};
              (msg.name != null && (changes.username = this._username = msg.name),
                msg.user_id != null && (changes.uniqueId = this._uniqueId = msg.user_id),
                msg.mute != null && (changes.mute = this._mute = msg.mute),
                msg.deaf != null && (changes.deaf = this._deaf = msg.deaf),
                msg.suppress != null && (changes.suppress = this._suppress = msg.suppress),
                msg.self_mute != null && (changes.selfMute = this._selfMute = msg.self_mute),
                msg.self_deaf != null && (changes.selfDeaf = this._selfDeaf = msg.self_deaf),
                msg.texture != null && (changes.texture = this._texture = msg.texture),
                msg.texture_hash != null &&
                  ((changes.textureHash = this._textureHash = msg.texture_hash), (this._haveRequestedTexture = !1)),
                msg.comment != null && (changes.comment = this._comment = msg.comment),
                msg.comment_hash != null &&
                  ((changes.commentHash = this._commentHash = msg.comment_hash), (this._haveRequestedComment = !1)),
                msg.priority_speaker != null &&
                  (changes.prioritySpeaker = this._prioritySpeaker = msg.priority_speaker),
                msg.recording != null && (changes.recording = this._recording = msg.recording),
                msg.hash != null && (changes.certHash = this._certHash = msg.hash),
                msg.channel_id != null &&
                  (this.channel && (0, _removeValue2.default)(this.channel.users, this),
                  (this._channelId = msg.channel_id),
                  this.channel && this.channel.users.push(this),
                  (changes.channel = this.channel)),
                this.emit('update', this._client._userById[msg.actor], changes));
            },
          },
          {
            key: '_remove',
            value: function (actor, reason, ban) {
              (this.channel && (0, _removeValue2.default)(this.channel.users, this),
                this.emit('remove', actor, reason, ban));
            },
          },
          {
            key: '_getOrCreateVoiceStream',
            value: function () {
              var _this2 = this;
              return (
                this._voice ||
                  (this._client._codecs
                    ? (this._voice = this._client._codecs.createDecoderStream(this))
                    : (this._voice = _dropStream2.default.obj()),
                  this._voice.once('close', function () {
                    _this2._voice = null;
                  }),
                  (this._voiceTimeout = new _rtimer2.default(function () {
                    (_this2._voice.end(), (_this2._voice = null));
                  }, this._client._options.userVoiceTimeout || 200).set()),
                  this.emit('voice', this._voice)),
                this._voice
              );
            },
          },
          {
            key: '_getDuration',
            value: function (codec, frames) {
              var _this3 = this;
              if (this._client._codecs) {
                var duration = 0;
                return (
                  frames.forEach(function (frame) {
                    duration += _this3._client._codecs.getDuration(codec, frame);
                  }),
                  duration
                );
              } else return frames.length * 10;
            },
          },
          {
            key: '_onVoice',
            value: function (seqNum, codec, target, frames, position, end) {
              var _this4 = this;
              if (frames.length > 0) {
                var duration = this._getDuration(codec, frames);
                if (this._voice != null) {
                  if (this._lastVoiceSeqId > seqNum) return;
                  if (this._lastVoiceSeqId < seqNum - duration / 10) {
                    var lost = seqNum - this._lastVoiceSeqId - 1;
                    lost > 10 && (lost = 10);
                    for (var i = 0; i < lost; i++)
                      this._getOrCreateVoiceStream().write({ target, codec, frame: null, position });
                  }
                }
                (frames.forEach(function (frame) {
                  _this4._getOrCreateVoiceStream().write({ target, codec, frame, position });
                }),
                  this._voiceTimeout.set(),
                  (this._lastVoiceSeqId = seqNum + duration / 10 - 1));
              }
              end &&
                this._voice &&
                (this._voiceTimeout.clear(), (this._voiceTimeout = null), this._voice.end(), (this._voice = null));
            },
          },
          {
            key: 'setMute',
            value: function (mute) {
              var message = { name: 'UserState', payload: { session: this._id, mute } };
              (mute || (message.payload.deaf = !1), this._client._send(message));
            },
          },
          {
            key: 'setDeaf',
            value: function (deaf) {
              var message = { name: 'UserState', payload: { session: this._id, deaf } };
              (deaf && (message.payload.mute = !0), this._client._send(message));
            },
          },
          {
            key: 'clearComment',
            value: function () {
              this._client._send({ name: 'UserState', payload: { session: this._id, comment: '' } });
            },
          },
          {
            key: 'clearTexture',
            value: function () {
              this._client._send({ name: 'UserState', payload: { session: this._id, texture: '' } });
            },
          },
          {
            key: 'requestComment',
            value: function () {
              this._haveRequestedComment ||
                (this._client._send({ name: 'RequestBlob', payload: { session_comment: this._id } }),
                (this._haveRequestedComment = !0));
            },
          },
          {
            key: 'requestTexture',
            value: function () {
              this._haveRequestedTexture ||
                (this._client._send({ name: 'RequestBlob', payload: { session_texture: this._id } }),
                (this._haveRequestedTexture = !0));
            },
          },
          {
            key: 'register',
            value: function () {
              this._client._send({ name: 'UserState', payload: { session: this._id, user_id: 0 } });
            },
          },
          {
            key: 'sendMessage',
            value: function (message) {
              this._client._send({ name: 'TextMessage', payload: { session: this._id, message } });
            },
          },
          {
            key: 'setChannel',
            value: function (channel) {
              this._client._send({ name: 'UserState', payload: { session: this._id, channel_id: channel._id } });
            },
          },
          {
            key: 'id',
            get: function () {
              return this._id;
            },
          },
          {
            key: 'username',
            get: function () {
              return this._username;
            },
            set: function (to) {
              throw new Error('Cannot set username.');
            },
          },
          {
            key: 'uniqueId',
            get: function () {
              return this._uniqueId;
            },
            set: function (to) {
              throw new Error('Cannot set uniqueId. Maybe try #register()?');
            },
          },
          {
            key: 'mute',
            get: function () {
              return this._mute;
            },
            set: function (to) {
              throw new Error('Cannot set mute. Use #setMute(mute) instead.');
            },
          },
          {
            key: 'deaf',
            get: function () {
              return this._deaf;
            },
            set: function (to) {
              throw new Error('Cannot set deaf. Use #setDeaf(deaf) instead.');
            },
          },
          {
            key: 'selfMute',
            get: function () {
              return this._selfMute;
            },
            set: function (to) {
              throw new Error('Cannot set selfMute. Use Client#setSelfMute(mute) instead.');
            },
          },
          {
            key: 'selfDeaf',
            get: function () {
              return this._selfDeaf;
            },
            set: function (to) {
              throw new Error('Cannot set selfDeaf. Use Client#setSelfDeaf(deaf) instead.');
            },
          },
          {
            key: 'suppress',
            get: function () {
              return this._suppress;
            },
            set: function (to) {
              throw new Error('Cannot set suppress.');
            },
          },
          {
            key: 'texture',
            get: function () {
              return this._texture;
            },
            set: function (to) {
              throw new Error('Cannot set texture. Use Client#setSelfTexture(texture) or #clearTexture() instead.');
            },
          },
          {
            key: 'textureHash',
            get: function () {
              return this._textureHash;
            },
            set: function (to) {
              throw new Error('Cannot set textureHash.');
            },
          },
          {
            key: 'comment',
            get: function () {
              return this._comment;
            },
            set: function (to) {
              throw new Error('Cannot set comment. Use Client#setSelfTexture(texture) or #clearComment() instead.');
            },
          },
          {
            key: 'commentHash',
            get: function () {
              return this._commentHash;
            },
            set: function (to) {
              throw new Error('Cannot set commentHash.');
            },
          },
          {
            key: 'prioritySpeaker',
            get: function () {
              return this._prioritySpeaker;
            },
            set: function (to) {
              throw new Error('Cannot set prioritySpeaker. Use #setPrioritySpeaker(prioSpeaker) instead.');
            },
          },
          {
            key: 'recording',
            get: function () {
              return this._recording;
            },
            set: function (to) {
              throw new Error('Cannot set recording. Use Client#setSelfRecording(recording) instead.');
            },
          },
          {
            key: 'certHash',
            get: function () {
              return this._certHash;
            },
            set: function (to) {
              throw new Error('Cannot set certHash.');
            },
          },
          {
            key: 'channel',
            get: function () {
              return this._channelId != null ? this._client._channelById[this._channelId] : null;
            },
            set: function (to) {
              throw new Error('Cannot set channel. Use #setChannel(channel) instead.');
            },
          },
        ]),
        User2
      );
    })(_events.EventEmitter);
    exports2.default = User;
  },
});
var require_channel = __commonJS({
  'node_modules/mumble-client/lib/channel.js'(exports2) {
    'use strict';
    Object.defineProperty(exports2, '__esModule', { value: !0 });
    var _createClass = (function () {
        function defineProperties(target, props) {
          for (var i = 0; i < props.length; i++) {
            var descriptor = props[i];
            ((descriptor.enumerable = descriptor.enumerable || !1),
              (descriptor.configurable = !0),
              'value' in descriptor && (descriptor.writable = !0),
              Object.defineProperty(target, descriptor.key, descriptor));
          }
        }
        return function (Constructor, protoProps, staticProps) {
          return (
            protoProps && defineProperties(Constructor.prototype, protoProps),
            staticProps && defineProperties(Constructor, staticProps),
            Constructor
          );
        };
      })(),
      _events = require('events'),
      _removeValue = require_remove_value(),
      _removeValue2 = _interopRequireDefault(_removeValue);
    function _interopRequireDefault(obj) {
      return obj && obj.__esModule ? obj : { default: obj };
    }
    function _classCallCheck(instance, Constructor) {
      if (!(instance instanceof Constructor)) throw new TypeError('Cannot call a class as a function');
    }
    function _possibleConstructorReturn(self2, call) {
      if (!self2) throw new ReferenceError("this hasn't been initialised - super() hasn't been called");
      return call && (typeof call == 'object' || typeof call == 'function') ? call : self2;
    }
    function _inherits(subClass, superClass) {
      if (typeof superClass != 'function' && superClass !== null)
        throw new TypeError('Super expression must either be null or a function, not ' + typeof superClass);
      ((subClass.prototype = Object.create(superClass && superClass.prototype, {
        constructor: { value: subClass, enumerable: !1, writable: !0, configurable: !0 },
      })),
        superClass &&
          (Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : (subClass.__proto__ = superClass)));
    }
    var Channel = (function (_EventEmitter) {
      _inherits(Channel2, _EventEmitter);
      function Channel2(client, id) {
        _classCallCheck(this, Channel2);
        var _this = _possibleConstructorReturn(
          this,
          (Channel2.__proto__ || Object.getPrototypeOf(Channel2)).call(this)
        );
        return (
          (_this._client = client),
          (_this._id = id),
          (_this._links = []),
          (_this.users = []),
          (_this.children = []),
          (_this._haveRequestedDescription = !1),
          _this
        );
      }
      return (
        _createClass(Channel2, [
          {
            key: '_remove',
            value: function () {
              (this.parent && (0, _removeValue2.default)(this.parent.children, this), this.emit('remove'));
            },
          },
          {
            key: '_update',
            value: function (msg) {
              var _this2 = this,
                changes = {};
              (msg.name != null && (changes.name = this._name = msg.name),
                msg.description != null && (changes.description = this._description = msg.description),
                msg.description_hash != null &&
                  ((changes.descriptionHash = this._descriptionHash = msg.description_hash),
                  (this._haveRequestedDescription = !1)),
                msg.temporary != null && (changes.temporary = this._temporary = msg.temporary),
                msg.position != null && (changes.position = this._position = msg.position),
                msg.max_users != null && (changes.maxUsers = this._maxUsers = msg.max_users),
                msg.links && ((this._links = msg.links), (changes.links = this.links)),
                msg.links_remove &&
                  ((this._links = this._links.filter(function (e) {
                    return !msg.links_remove.includes(e);
                  })),
                  (changes.links = this.links)),
                msg.links_add &&
                  (msg.links_add
                    .filter(function (e) {
                      return !_this2._links.includes(e);
                    })
                    .forEach(function (e) {
                      return _this2._links.push(e);
                    }),
                  (changes.links = this.links)),
                msg.parent != null &&
                  (this.parent && (0, _removeValue2.default)(this.parent.children, this),
                  (this._parentId = msg.parent),
                  this.parent && this.parent.children.push(this),
                  (changes.parent = this.parent)),
                this.emit('update', changes));
            },
          },
          {
            key: 'setName',
            value: function (name) {
              this._client._send({ name: 'ChannelState', payload: { channel_id: this._id, name } });
            },
          },
          {
            key: 'setParent',
            value: function (parent) {
              this._client._send({ name: 'ChannelState', payload: { channel_id: this._id, parent: parent._id } });
            },
          },
          {
            key: 'setTemporary',
            value: function (temporary) {
              this._client._send({ name: 'ChannelState', payload: { channel_id: this._id, temporary } });
            },
          },
          {
            key: 'setDescription',
            value: function (description) {
              this._client._send({ name: 'ChannelState', payload: { channel_id: this._id, description } });
            },
          },
          {
            key: 'setPosition',
            value: function (position) {
              this._client._send({ name: 'ChannelState', payload: { channel_id: this._id, position } });
            },
          },
          {
            key: 'setLinks',
            value: function (links) {
              this._client._send({
                name: 'ChannelState',
                payload: {
                  channel_id: this._id,
                  links: links.map(function (c) {
                    return c._id;
                  }),
                },
              });
            },
          },
          {
            key: 'setMaxUsers',
            value: function (maxUsers) {
              this._client._send({ name: 'ChannelState', payload: { channel_id: this._id, max_users: maxUsers } });
            },
          },
          {
            key: 'sendMessage',
            value: function (message) {
              this._client._send({ name: 'TextMessage', payload: { channel_id: [this._id], message } });
            },
          },
          {
            key: 'sendTreeMessage',
            value: function (message) {
              this._client._send({ name: 'TextMessage', payload: { tree_id: [this._id], message } });
            },
          },
          {
            key: 'requestDescription',
            value: function () {
              this._haveRequestedDescription ||
                (this._client._send({ name: 'RequestBlob', payload: { channel_description: this._id } }),
                (this._haveRequestedDescription = !0));
            },
          },
          {
            key: 'id',
            get: function () {
              return this._id;
            },
          },
          {
            key: 'name',
            get: function () {
              return this._name;
            },
            set: function (to) {
              throw new Error('Cannot set name. Use #setName(name) instead.');
            },
          },
          {
            key: 'parent',
            get: function () {
              return this._client._channelById[this._parentId];
            },
            set: function (to) {
              throw new Error('Cannot set parent. Use #setParent(channel) instead.');
            },
          },
          {
            key: 'description',
            get: function () {
              return this._description;
            },
            set: function (to) {
              throw new Error('Cannot set description. Use #setDescription(desc) instead.');
            },
          },
          {
            key: 'descriptionHash',
            get: function () {
              return this._descriptionHash;
            },
            set: function (to) {
              throw new Error('Cannot set descriptionHash.');
            },
          },
          {
            key: 'temporary',
            get: function () {
              return this._temporary;
            },
            set: function (to) {
              throw new Error('Cannot set temporary. Use #setTemporary(tmp) instead.');
            },
          },
          {
            key: 'position',
            get: function () {
              return this._position;
            },
            set: function (to) {
              throw new Error('Cannot set position.');
            },
          },
          {
            key: 'maxUsers',
            get: function () {
              return this._maxUsers;
            },
            set: function (to) {
              throw new Error('Cannot set maxUsers.');
            },
          },
          {
            key: 'links',
            get: function () {
              var _this3 = this;
              return this._links.map(function (id) {
                return _this3._client._channelById[id];
              });
            },
            set: function (to) {
              throw new Error('Cannot set links. Use #setLinks(links) instead.');
            },
          },
        ]),
        Channel2
      );
    })(_events.EventEmitter);
    exports2.default = Channel;
  },
});
var require_isnumber = __commonJS({
  'node_modules/isnumber/index.js'(exports2, module2) {
    'use strict';
    module2.exports = isNumber;
    function isNumber(n) {
      return !isNaN(parseFloat(n)) && isFinite(n);
    }
  },
});
var require_stats = __commonJS({
  'node_modules/stats-lite/stats.js'(exports2, module2) {
    'use strict';
    module2.exports.numbers = numbers;
    module2.exports.sum = sum;
    module2.exports.mean = mean;
    module2.exports.median = median;
    module2.exports.mode = mode;
    module2.exports.variance = populationVariance;
    module2.exports.sampleVariance = sampleVariance;
    module2.exports.populationVariance = populationVariance;
    module2.exports.stdev = populationStdev;
    module2.exports.sampleStdev = sampleStdev;
    module2.exports.populationStdev = populationStdev;
    module2.exports.percentile = percentile;
    module2.exports.histogram = histogram;
    var isNumber = require_isnumber();
    function numbers(vals) {
      var nums = [];
      if (vals == null) return nums;
      for (var i = 0; i < vals.length; i++) isNumber(vals[i]) && nums.push(+vals[i]);
      return nums;
    }
    function nsort(vals) {
      return vals.sort(function (a, b) {
        return a - b;
      });
    }
    function sum(vals) {
      vals = numbers(vals);
      for (var total = 0, i = 0; i < vals.length; i++) total += vals[i];
      return total;
    }
    function mean(vals) {
      return ((vals = numbers(vals)), vals.length === 0 ? NaN : sum(vals) / vals.length);
    }
    function median(vals) {
      if (((vals = numbers(vals)), vals.length === 0)) return NaN;
      var half = (vals.length / 2) | 0;
      return ((vals = nsort(vals)), vals.length % 2 ? vals[half] : (vals[half - 1] + vals[half]) / 2);
    }
    function mode(vals) {
      if (((vals = numbers(vals)), vals.length === 0)) return NaN;
      for (var mode2 = NaN, dist = {}, i = 0; i < vals.length; i++) {
        var value = vals[i],
          me = dist[value] || 0;
        (me++, (dist[value] = me));
      }
      var rank = numbers(
        Object.keys(dist).sort(function (a, b) {
          return dist[b] - dist[a];
        })
      );
      if (((mode2 = rank[0]), dist[rank[1]] == dist[mode2])) {
        if (rank.length == vals.length) return vals;
        for (
          var modes = new Set([mode2]), modeCount = dist[mode2], i = 1;
          i < rank.length && dist[rank[i]] == modeCount;
          i++
        )
          modes.add(rank[i]);
        return modes;
      }
      return mode2;
    }
    function valuesMinusMeanSquared(vals) {
      vals = numbers(vals);
      for (var avg = mean(vals), diffs = [], i = 0; i < vals.length; i++) diffs.push(Math.pow(vals[i] - avg, 2));
      return diffs;
    }
    function populationVariance(vals) {
      return mean(valuesMinusMeanSquared(vals));
    }
    function sampleVariance(vals) {
      var diffs = valuesMinusMeanSquared(vals);
      return diffs.length <= 1 ? NaN : sum(diffs) / (diffs.length - 1);
    }
    function populationStdev(vals) {
      return Math.sqrt(populationVariance(vals));
    }
    function sampleStdev(vals) {
      return Math.sqrt(sampleVariance(vals));
    }
    function percentile(vals, ptile) {
      if (((vals = numbers(vals)), vals.length === 0 || ptile == null || ptile < 0)) return NaN;
      (ptile > 1 && (ptile = 1), (vals = nsort(vals)));
      var i = vals.length * ptile - 0.5;
      if ((i | 0) === i) return vals[i];
      var int_part = i | 0,
        fract = i - int_part;
      return (1 - fract) * vals[int_part] + fract * vals[Math.min(int_part + 1, vals.length - 1)];
    }
    function histogram(vals, bins) {
      if (vals == null || ((vals = nsort(numbers(vals))), vals.length === 0)) return null;
      (bins == null && (bins = Math.sqrt(vals.length)), (bins = Math.round(bins)), bins < 1 && (bins = 1));
      var min = vals[0],
        max = vals[vals.length - 1];
      min === max && ((min = min - 0.5), (max = max + 0.5));
      var range = max - min,
        binWidth = (range + range * 0.05) / bins,
        midpoint = (min + max) / 2,
        leftEdge = midpoint - binWidth * Math.floor(bins / 2);
      if (bins % 2 !== 0) var leftEdge = midpoint - binWidth / 2 - binWidth * Math.floor(bins / 2);
      for (
        var hist = { values: Array(bins).fill(0), bins, binWidth, binLimits: [leftEdge, leftEdge + binWidth * bins] },
          binIndex = 0,
          i = 0;
        i < vals.length;
        i++
      ) {
        for (; vals[i] > (binIndex + 1) * binWidth + leftEdge; ) binIndex++;
        hist.values[binIndex]++;
      }
      return hist;
    }
  },
});
var require_stats2 = __commonJS({
  'node_modules/stats-incremental/stats.js'(exports2, module2) {
    'use strict';
    var statslite = require_stats();
    module2.exports = Stats;
    function Stats(smaBins) {
      if (!(this instanceof Stats)) return new Stats(smaBins);
      if (
        ((this.n = 0),
        (this.min = Number.MAX_VALUE),
        (this.max = -Number.MAX_VALUE),
        (this.sum = 0),
        (this.mean = 0),
        (smaBins == null || smaBins <= 0) && (smaBins = 50),
        smaBins !== (smaBins | 0))
      )
        throw new Error('SMA option must be an integer');
      (Object.defineProperty(this, 'smaBins', { enumerable: !1, writable: !1, value: smaBins }),
        Object.defineProperty(this, '_bins', { enumerable: !1, writable: !1, value: [] }),
        Object.defineProperty(this, 'q', { enumerable: !1, writable: !0, value: 0 }),
        Object.defineProperty(this, 'variance', { enumerable: !0, get: () => this.q / this.n }),
        Object.defineProperty(this, 'standard_deviation', { enumerable: !0, get: () => Math.sqrt(this.q / this.n) }),
        Object.defineProperty(this, `sma${smaBins}`, { enumerable: !0, get: () => statslite.mean(this._bins) }));
    }
    Stats.prototype.update = function (value) {
      var num = parseFloat(value);
      if (!isNaN(num)) {
        (this.n++, (this.min = Math.min(this.min, num)), (this.max = Math.max(this.max, num)), (this.sum += num));
        var prevMean = this.mean;
        ((this.mean = this.mean + (num - this.mean) / this.n),
          (this.q = this.q + (num - prevMean) * (num - this.mean)),
          this._bins.push(value),
          this._bins.length > this.smaBins && this._bins.shift());
      }
    };
    Stats.prototype.getAll = function () {
      if (this.n === 0) return null;
      var s = {
        n: this.n,
        min: this.min,
        max: this.max,
        sum: this.sum,
        mean: this.mean,
        variance: this.variance,
        standard_deviation: this.standard_deviation,
      };
      return ((s[`sma${this.smaBins}`] = this[`sma${this.smaBins}`]), s);
    };
  },
});
var require_client = __commonJS({
  'node_modules/mumble-client/lib/client.js'(exports2) {
    'use strict';
    Object.defineProperty(exports2, '__esModule', { value: !0 });
    var _createClass = (function () {
        function defineProperties(target, props) {
          for (var i = 0; i < props.length; i++) {
            var descriptor = props[i];
            ((descriptor.enumerable = descriptor.enumerable || !1),
              (descriptor.configurable = !0),
              'value' in descriptor && (descriptor.writable = !0),
              Object.defineProperty(target, descriptor.key, descriptor));
          }
        }
        return function (Constructor, protoProps, staticProps) {
          return (
            protoProps && defineProperties(Constructor.prototype, protoProps),
            staticProps && defineProperties(Constructor, staticProps),
            Constructor
          );
        };
      })(),
      _mumbleStreams = require_mumble_streams(),
      _mumbleStreams2 = _interopRequireDefault(_mumbleStreams),
      _reduplexer = require_reduplexer(),
      _reduplexer2 = _interopRequireDefault(_reduplexer),
      _events = require('events'),
      _through = require_through2(),
      _through2 = _interopRequireDefault(_through),
      _promise = require_promise(),
      _promise2 = _interopRequireDefault(_promise),
      _dropStream = require_drop_stream(),
      _dropStream2 = _interopRequireDefault(_dropStream),
      _utils = require_utils(),
      _user2 = require_user(),
      _user3 = _interopRequireDefault(_user2),
      _channel = require_channel(),
      _channel2 = _interopRequireDefault(_channel),
      _removeValue = require_remove_value(),
      _removeValue2 = _interopRequireDefault(_removeValue),
      _statsIncremental = require_stats2(),
      _statsIncremental2 = _interopRequireDefault(_statsIncremental);
    function _interopRequireDefault(obj) {
      return obj && obj.__esModule ? obj : { default: obj };
    }
    function _classCallCheck(instance, Constructor) {
      if (!(instance instanceof Constructor)) throw new TypeError('Cannot call a class as a function');
    }
    function _possibleConstructorReturn(self2, call) {
      if (!self2) throw new ReferenceError("this hasn't been initialised - super() hasn't been called");
      return call && (typeof call == 'object' || typeof call == 'function') ? call : self2;
    }
    function _inherits(subClass, superClass) {
      if (typeof superClass != 'function' && superClass !== null)
        throw new TypeError('Super expression must either be null or a function, not ' + typeof superClass);
      ((subClass.prototype = Object.create(superClass && superClass.prototype, {
        constructor: { value: subClass, enumerable: !1, writable: !0, configurable: !0 },
      })),
        superClass &&
          (Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : (subClass.__proto__ = superClass)));
    }
    var DenyType = _mumbleStreams2.default.data.messages.PermissionDenied.DenyType,
      MumbleClient2 = (function (_EventEmitter) {
        _inherits(MumbleClient3, _EventEmitter);
        function MumbleClient3(options) {
          _classCallCheck(this, MumbleClient3);
          var _this = _possibleConstructorReturn(
            this,
            (MumbleClient3.__proto__ || Object.getPrototypeOf(MumbleClient3)).call(this)
          );
          if (!options.username) throw new Error('No username given');
          return (
            (_this._options = options || {}),
            (_this._username = options.username),
            (_this._password = options.password),
            (_this._tokens = options.tokens),
            (_this._codecs = options.codecs),
            (_this._dataPingInterval = options.dataPingInterval || 5e3),
            (_this._maxInFlightDataPings = options.maxInFlightDataPings || 2),
            (_this._dataStats = new _statsIncremental2.default()),
            (_this._voiceStats = new _statsIncremental2.default()),
            (_this._userById = {}),
            (_this._channelById = {}),
            (_this.users = []),
            (_this.channels = []),
            (_this._dataEncoder = new _mumbleStreams2.default.data.Encoder()),
            (_this._dataDecoder = new _mumbleStreams2.default.data.Decoder()),
            (_this._voiceEncoder = new _mumbleStreams2.default.voice.Encoder('server')),
            (_this._voiceDecoder = new _mumbleStreams2.default.voice.Decoder('server')),
            (_this._data = (0, _reduplexer2.default)(_this._dataEncoder, _this._dataDecoder, { objectMode: !0 })),
            (_this._voice = (0, _reduplexer2.default)(_this._voiceEncoder, _this._voiceDecoder, { objectMode: !0 })),
            _this._data.on('data', _this._onData.bind(_this)),
            _this._voice.on('data', _this._onVoice.bind(_this)),
            _this._voiceEncoder.on('data', function (data) {
              _this._data.write({ name: 'UDPTunnel', payload: data });
            }),
            _this._voiceDecoder.on('unknown_codec', function (codecId) {
              return _this.emit('unknown_codec', codecId);
            }),
            _this._data.on('end', _this.disconnect.bind(_this)),
            _this._registerErrorHandler(
              _this._data,
              _this._voice,
              _this._dataEncoder,
              _this._dataDecoder,
              _this._voiceEncoder,
              _this._voiceDecoder
            ),
            (_this._disconnected = !1),
            _this
          );
        }
        return (
          _createClass(
            MumbleClient3,
            [
              {
                key: '_registerErrorHandler',
                value: function () {
                  var _iteratorNormalCompletion = !0,
                    _didIteratorError = !1,
                    _iteratorError = void 0;
                  try {
                    for (
                      var _iterator = arguments[Symbol.iterator](), _step;
                      !(_iteratorNormalCompletion = (_step = _iterator.next()).done);
                      _iteratorNormalCompletion = !0
                    ) {
                      var obj = _step.value;
                      obj.on('error', this._error.bind(this));
                    }
                  } catch (err) {
                    ((_didIteratorError = !0), (_iteratorError = err));
                  } finally {
                    try {
                      !_iteratorNormalCompletion && _iterator.return && _iterator.return();
                    } finally {
                      if (_didIteratorError) throw _iteratorError;
                    }
                  }
                },
              },
              {
                key: '_error',
                value: function (reason) {
                  (this.emit('error', reason), this.disconnect());
                },
              },
              {
                key: '_send',
                value: function (msg) {
                  this._data.write(msg);
                },
              },
              {
                key: 'connectDataStream',
                value: function (stream, callback) {
                  var _this2 = this;
                  if (this._dataStream) throw Error('Already connected!');
                  return (
                    (this._dataStream = stream),
                    this._registerErrorHandler(stream),
                    this._dataEncoder.pipe(stream).pipe(this._dataDecoder),
                    this._send({
                      name: 'Version',
                      payload: {
                        version: _mumbleStreams2.default.version.toUInt8(),
                        release: this._options.clientSoftware || 'Node.js mumble-client',
                        os: this._options.osName || (0, _utils.getOSName)(),
                        os_version: this._options.osVersion || (0, _utils.getOSVersion)(),
                      },
                    }),
                    this._send({
                      name: 'Authenticate',
                      payload: {
                        username: this._username,
                        password: this._password,
                        tokens: this._tokens,
                        celt_versions: (this._codecs || { celt: [] }).celt,
                        opus: (this._codecs || { opus: !1 }).opus,
                      },
                    }),
                    new _promise2.default(function (resolve, reject) {
                      (_this2.once('connected', function () {
                        return resolve(_this2);
                      }),
                        _this2.once('reject', reject),
                        _this2.once('error', reject));
                    }).nodeify(callback)
                  );
                },
              },
              {
                key: 'connectVoiceStream',
                value: function (stream) {
                  (this._registerErrorHandler(stream), this._voiceEncoder.pipe(stream).pipe(this._voiceDecoder));
                },
              },
              {
                key: 'createVoiceStream',
                value: function () {
                  var _this3 = this,
                    target = arguments.length > 0 && arguments[0] !== void 0 ? arguments[0] : 0,
                    numberOfChannels = arguments.length > 1 && arguments[1] !== void 0 ? arguments[1] : 1;
                  if (!this._codecs) return _dropStream2.default.obj();
                  var voiceStream = _through2.default.obj(function (chunk, encoding, callback) {
                      (chunk instanceof Buffer &&
                        (chunk = new Float32Array(chunk.buffer, chunk.byteOffset, chunk.byteLength / 4)),
                        chunk instanceof Float32Array
                          ? (chunk = { target, pcm: chunk, numberOfChannels })
                          : (chunk = {
                              target,
                              pcm: chunk.pcm,
                              numberOfChannels,
                              position: { x: chunk.x, y: chunk.y, z: chunk.z },
                            }));
                      var samples = _this3._samplesPerPacket || chunk.pcm.length / numberOfChannels;
                      ((chunk.bitrate = _this3.getActualBitrate(samples, chunk.position != null)),
                        callback(null, chunk));
                    }),
                    codec = 'Opus',
                    seqNum = 0;
                  return (
                    voiceStream
                      .pipe(this._codecs.createEncoderStream(codec))
                      .on('data', function (data) {
                        var duration = _this3._codecs.getDuration(codec, data.frame) / 10;
                        (_this3._voice.write({
                          seqNum,
                          codec,
                          mode: target,
                          frames: [data.frame],
                          position: data.position,
                          end: !1,
                        }),
                          (seqNum += duration));
                      })
                      .on('end', function () {
                        _this3._voice.write({ seqNum, codec, mode: target, frames: [], end: !0 });
                      }),
                    voiceStream
                  );
                },
              },
              {
                key: '_onVoice',
                value: function (chunk) {
                  var user = this._userById[chunk.source];
                  user._onVoice(chunk.seqNum, chunk.codec, chunk.target, chunk.frames, chunk.position, chunk.end);
                },
              },
              {
                key: '_onData',
                value: function (chunk) {
                  this['_on' + chunk.name]
                    ? this['_on' + chunk.name](chunk.payload)
                    : console.log('Unhandled data packet:', chunk);
                },
              },
              {
                key: '_onUDPTunnel',
                value: function (payload) {
                  this._voiceDecoder.write(payload);
                },
              },
              {
                key: '_onVersion',
                value: function (payload) {
                  this.serverVersion = {
                    major: payload.version >> 16,
                    minor: (payload.version >> 8) & 255,
                    patch: (payload.version >> 0) & 255,
                    release: payload.release,
                    os: payload.os,
                    osVersion: payload.os_version,
                  };
                },
              },
              {
                key: '_onServerSync',
                value: function (payload) {
                  var _this4 = this;
                  ((this.self = this._userById[payload.session]),
                    (this.maxBandwidth = payload.max_bandwidth),
                    (this.welcomeMessage = payload.welcome_text),
                    (this._pinger = setInterval(function () {
                      if (_this4._inFlightDataPings >= _this4._maxInFlightDataPings) {
                        _this4._error('timeout');
                        return;
                      }
                      var dataStats = _this4._dataStats.getAll(),
                        voiceStats = _this4._voiceStats.getAll(),
                        timestamp = new Date().getTime(),
                        payload2 = { timestamp };
                      (dataStats &&
                        ((payload2.tcp_packets = dataStats.n),
                        (payload2.tcp_ping_avg = dataStats.mean),
                        (payload2.tcp_ping_var = dataStats.variance)),
                        voiceStats &&
                          ((payload2.udp_packets = voiceStats.n),
                          (payload2.udp_ping_avg = voiceStats.mean),
                          (payload2.udp_ping_var = voiceStats.variance)),
                        _this4._send({ name: 'Ping', payload: payload2 }),
                        _this4._inFlightDataPings++);
                    }, this._dataPingInterval)),
                    this.emit('connected'));
                },
              },
              {
                key: '_onPing',
                value: function (payload) {
                  if (this._inFlightDataPings <= 0) {
                    console.warn('Got unexpected ping message:', payload);
                    return;
                  }
                  this._inFlightDataPings--;
                  var now = new Date().getTime(),
                    duration = now - payload.timestamp.toNumber();
                  (this._dataStats.update(duration), this.emit('dataPing', duration));
                },
              },
              {
                key: '_onReject',
                value: function (payload) {
                  (this.emit('reject', payload), this.disconnect());
                },
              },
              {
                key: '_onPermissionDenied',
                value: function (payload) {
                  if (payload.type === DenyType.Text) this.emit('denied', 'Text', null, null, payload.reason);
                  else if (payload.type === DenyType.Permission) {
                    var user = this._userById[payload.session],
                      channel = this._channelById[payload.channel_id];
                    this.emit('denied', 'Permission', user, channel, payload.permission);
                  } else if (payload.type === DenyType.SuperUser) this.emit('denied', 'SuperUser', null, null, null);
                  else if (payload.type === DenyType.ChannelName)
                    this.emit('denied', 'ChannelName', null, null, payload.name);
                  else if (payload.type === DenyType.TextTooLong) this.emit('denied', 'TextTooLong', null, null, null);
                  else if (payload.type === DenyType.TemporaryChannel)
                    this.emit('denied', 'TemporaryChannel', null, null, null);
                  else if (payload.type === DenyType.MissingCertificate) {
                    var _user = this._userById[payload.session];
                    this.emit('denied', 'MissingCertificate', _user, null, null);
                  } else if (payload.type === DenyType.UserName)
                    this.emit('denied', 'UserName', null, null, payload.name);
                  else if (payload.type === DenyType.ChannelFull) this.emit('denied', 'ChannelFull', null, null, null);
                  else if (payload.type === DenyType.NestingLimit)
                    this.emit('denied', 'NestingLimit', null, null, null);
                  else throw Error('Invalid DenyType: ' + payload.type);
                },
              },
              {
                key: '_onTextMessage',
                value: function (payload) {
                  var _this5 = this;
                  this.emit(
                    'message',
                    this._userById[payload.actor],
                    payload.message,
                    payload.session.map(function (id) {
                      return _this5._userById[id];
                    }),
                    payload.channel_id.map(function (id) {
                      return _this5._channelById[id];
                    }),
                    payload.tree_id.map(function (id) {
                      return _this5._channelById[id];
                    })
                  );
                },
              },
              {
                key: '_onChannelState',
                value: function (payload) {
                  var _this6 = this,
                    channel = this._channelById[payload.channel_id];
                  (channel ||
                    ((channel = new _channel2.default(this, payload.channel_id)),
                    (this._channelById[channel._id] = channel),
                    this.channels.push(channel),
                    this.emit('newChannel', channel)),
                    (payload.links_remove || []).forEach(function (otherId) {
                      var otherChannel = _this6._channelById[otherId];
                      otherChannel &&
                        otherChannel.links.indexOf(channel) !== -1 &&
                        otherChannel._update({ links_remove: [payload.channel_id] });
                    }),
                    channel._update(payload));
                },
              },
              {
                key: '_onChannelRemove',
                value: function (payload) {
                  var channel = this._channelById[payload.channel_id];
                  channel &&
                    (channel._remove(),
                    delete this._channelById[channel._id],
                    (0, _removeValue2.default)(this.channels, channel));
                },
              },
              {
                key: '_onUserState',
                value: function (payload) {
                  var user = this._userById[payload.session];
                  (user ||
                    ((user = new _user3.default(this, payload.session)),
                    (this._userById[user._id] = user),
                    this.users.push(user),
                    this.emit('newUser', user),
                    (payload.channel_id = payload.channel_id || 0)),
                    user._update(payload));
                },
              },
              {
                key: '_onUserRemove',
                value: function (payload) {
                  var user = this._userById[payload.session];
                  user &&
                    (user._remove(this._userById[payload.actor], payload.reason, payload.ban),
                    delete this._userById[user._id],
                    (0, _removeValue2.default)(this.users, user));
                },
              },
              {
                key: 'disconnect',
                value: function () {
                  this._disconnected ||
                    ((this._disconnected = !0),
                    this._voice.end(),
                    this._data.end(),
                    clearInterval(this._pinger),
                    this.emit('disconnected'));
                },
              },
              {
                key: 'setAudioQuality',
                value: function (bitrate, samplesPerPacket) {
                  ((this._preferredBitrate = bitrate), (this._samplesPerPacket = samplesPerPacket));
                },
              },
              {
                key: 'getActualBitrate',
                value: function (samplesPerPacket, sendPosition) {
                  var bitrate = this.getPreferredBitrate(samplesPerPacket, sendPosition),
                    bandwidth = MumbleClient3.calcEnforcableBandwidth(bitrate, samplesPerPacket, sendPosition);
                  return bandwidth <= this.maxBandwidth ? bitrate : this.getMaxBitrate(samplesPerPacket, sendPosition);
                },
              },
              {
                key: 'getPreferredBitrate',
                value: function (samplesPerPacket, sendPosition) {
                  return this._preferredBitrate
                    ? this._preferredBitrate
                    : this.getMaxBitrate(samplesPerPacket, sendPosition);
                },
              },
              {
                key: 'getMaxBitrate',
                value: function (samplesPerPacket, sendPosition) {
                  var overhead = MumbleClient3.calcEnforcableBandwidth(0, samplesPerPacket, sendPosition);
                  return this.maxBandwidth - overhead;
                },
              },
              {
                key: 'getChannel',
                value: function (name) {
                  var _iteratorNormalCompletion2 = !0,
                    _didIteratorError2 = !1,
                    _iteratorError2 = void 0;
                  try {
                    for (
                      var _iterator2 = this.channels[Symbol.iterator](), _step2;
                      !(_iteratorNormalCompletion2 = (_step2 = _iterator2.next()).done);
                      _iteratorNormalCompletion2 = !0
                    ) {
                      var channel = _step2.value;
                      if (channel.name === name) return channel;
                    }
                  } catch (err) {
                    ((_didIteratorError2 = !0), (_iteratorError2 = err));
                  } finally {
                    try {
                      !_iteratorNormalCompletion2 && _iterator2.return && _iterator2.return();
                    } finally {
                      if (_didIteratorError2) throw _iteratorError2;
                    }
                  }
                  return null;
                },
              },
              {
                key: 'setSelfMute',
                value: function (mute) {
                  var message = { name: 'UserState', payload: { session: this.self._id, self_mute: mute } };
                  (mute || (message.payload.self_deaf = !1), this._send(message));
                },
              },
              {
                key: 'setSelfDeaf',
                value: function (deaf) {
                  var message = { name: 'UserState', payload: { session: this.self._id, self_deaf: deaf } };
                  (deaf && (message.payload.self_mute = !0), this._send(message));
                },
              },
              {
                key: 'setSelfTexture',
                value: function (texture) {
                  this._send({ name: 'UserState', payload: { session: this.self._id, texture } });
                },
              },
              {
                key: 'setSelfComment',
                value: function (comment) {
                  this._send({ name: 'UserState', payload: { session: this.self._id, comment } });
                },
              },
              {
                key: 'setPluginContext',
                value: function (context) {
                  this._send({ name: 'UserState', payload: { session: this.self._id, plugin_context: context } });
                },
              },
              {
                key: 'setPluginIdentity',
                value: function (identity) {
                  this._send({ name: 'UserState', payload: { session: this.self._id, plugin_identity: identity } });
                },
              },
              {
                key: 'setRecording',
                value: function (recording) {
                  this._send({ name: 'UserState', payload: { session: this.self._id, recording } });
                },
              },
              {
                key: 'getChannelById',
                value: function (id) {
                  return this._channelById[id];
                },
              },
              {
                key: 'getUserById',
                value: function (id) {
                  return this._userById[id];
                },
              },
              {
                key: 'root',
                get: function () {
                  return this._channelById[0];
                },
              },
              {
                key: 'connected',
                get: function () {
                  return !this._disconnected && this._dataStream != null;
                },
              },
              {
                key: 'dataStats',
                get: function () {
                  return this._dataStats.getAll();
                },
              },
              {
                key: 'voiceStats',
                get: function () {
                  return this._voiceStats.getAll();
                },
              },
            ],
            [
              {
                key: 'calcEnforcableBandwidth',
                value: function (bitrate, samplesPerPacket, sendPosition) {
                  var codecHeaderBytes = Math.max(4, samplesPerPacket / 480),
                    packetBytes = 37 + codecHeaderBytes + (sendPosition ? 12 : 0),
                    packetsPerSecond = 48e3 / samplesPerPacket;
                  return Math.round(packetBytes * 8 * packetsPerSecond + bitrate);
                },
              },
            ]
          ),
          MumbleClient3
        );
      })(_events.EventEmitter);
    exports2.default = MumbleClient2;
  },
});
var require_mumble_client = __commonJS({
  'node_modules/mumble-client/index.js'(exports2, module2) {
    'use strict';
    module2.exports = require_client().default;
  },
});
var mumble_client_sdk_exports = {};
__export(mumble_client_sdk_exports, { default: () => mumble_client_sdk_default });
module.exports = __toCommonJS(mumble_client_sdk_exports);
var import_mumble_client = __toESM(require_mumble_client(), 1),
  mumble_client_sdk_default = import_mumble_client.default;
