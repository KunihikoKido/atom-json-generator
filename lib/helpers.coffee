dummyjson = require 'dummy-json'
fs = require 'fs'
path = require 'path'

japaneseText = fs.readFileSync(path.join(__dirname, 'japanese.txt'), {encoding: 'utf8'})


module.exports =
  languageCode: () ->
    return dummyjson.utils.randomArrayItem([
      "ab", "aa", "af", "ak", "sq", "am", "ar", "an", "hy", "as", "av",
      "ae", "ay", "az", "bm", "ba", "eu", "be", "bn", "bh", "bi", "bs",
      "br", "bg", "my", "ca", "ch", "ce", "ny", "zh", "cv", "kw", "co",
      "cr", "hr", "cs", "da", "dv", "nl", "dz", "en", "eo", "et", "ee",
      "fo", "fj", "fi", "fr", "ff", "gl", "ka", "de", "el", "gn", "gu",
      "ht", "ha", "he", "hz", "hi", "ho", "hu", "ia", "id", "ie", "ga",
      "ig", "ik", "io", "is", "it", "iu", "ja", "jv", "kl", "kn", "kr",
      "ks", "kk", "km", "ki", "rw", "ky", "kv", "kg", "ko", "ku", "kj",
      "la", "lb", "lg", "li", "ln", "lo", "lt", "lu", "lv", "gv", "mk",
      "mg", "ms", "ml", "mt", "mi", "mr", "mh", "mn", "na", "nv", "nb",
      "nd", "ne", "ng", "nn", "no", "ii", "nr", "oc", "oj", "cu", "om",
      "or", "os", "pa", "pi", "fa", "pl", "ps", "pt", "qu", "rm", "rn",
      "ro", "ru", "sa", "sc", "sd", "se", "sm", "sg", "sr", "gd", "sn",
      "si", "sk", "sl", "so", "st", "es", "su", "sw", "ss", "sv", "ta",
      "te", "tg", "th", "ti", "bo", "tk", "tl", "tn", "to", "tr", "ts",
      "tt", "tw", "ty", "ug", "uk", "ur", "uz", "ve", "vi", "vo", "wa",
      "cy", "wo", "fy", "xh", "yi", "yo", "za", "zu"])

  currencyCode: () ->
    return dummyjson.utils.randomArrayItem([
      "AED", "AFN", "ALL", "AMD", "ANG", "AOA", "ARS", "AUD", "AWG", "AZN",
      "BAM", "BBD", "BDT", "BGN", "BHD", "BIF", "BMD", "BND", "BOB", "BRL",
      "BSD", "BTN", "BWP", "BYR", "BZD", "CAD", "CDF", "CHF", "CLP", "CNY",
      "COP", "CRC", "CUC", "CUP", "CVE", "CZK", "DJF", "DKK", "DOP", "DZD",
      "EGP", "ERN", "ETB", "EUR", "FJD", "FKP", "GBP", "GEL", "GGP", "GHS",
      "GIP", "GMD", "GNF", "GTQ", "GYD", "HKD", "HNL", "HRK", "HTG", "HUF",
      "IDR", "ILS", "INR", "IQD", "IRR", "ISK", "JMD", "JOD", "JPY", "KES",
      "KGS", "KHR", "KMF", "KPW", "KRW", "KWD", "KYD", "KZT", "LAK", "LBP",
      "LKR", "LRD", "LSL", "LYD", "MAD", "MDL", "MGA", "MKD", "MMK", "MNT",
      "MOP", "MRO", "MUR", "MVR", "MWK", "MXN", "MYR", "MZN", "NAD", "NGN",
      "NIO", "NOK", "NPR", "NZD", "OMR", "PAB", "PEN", "PGK", "PHP", "PKR",
      "PLN", "PYG", "QAR", "RON", "RSD", "RUB", "RWF", "SAR", "SBD", "SCR",
      "SDG", "SEK", "SGD", "SHP", "SLL", "SOS", "SRD", "SSP", "STD", "SVC",
      "SYP", "SZL", "THB", "TJS", "TMT", "TND", "TOP", "TRY", "TTD", "TWD",
      "TZS", "UAH", "UGX", "USD", "UYU", "UZS", "VEF", "VND", "VUV", "WST",
      "XAF", "XAG", "XAU", "XCD", "XDR", "XOF", "XPD", "XPF", "XPT", "XTS",
      "XXX", "YER", "ZAR", "ZMK", "ZWD"
    ])

  jaLorem: (totalSentences, options) ->
    if !options
      options = totalSentences
      totalSentences = 1

    items = japaneseText.split("\n")

    console.log totalSentences

    ret = ""

    for i in [1..totalSentences]
      sentence = dummyjson.utils.randomArrayItem(items)
      sentences = sentence.split('、')
      if sentences.length > 2
        sentence = sentences[-1..]  # end
      ret = ret + sentence

    ret = ret.trimRight()
    return ret
