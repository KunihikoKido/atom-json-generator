dummyjson = require 'dummy-json'
fs = require 'fs'
path = require 'path'

japaneseText = fs.readFileSync(path.join(__dirname, 'japanese.txt'), {encoding: 'utf8'})


module.exports =
  language: (options) ->
    return dummyjson.utils.randomArrayItem(options.data.root.languages)

  currency: (options) ->
    return dummyjson.utils.randomArrayItem(options.data.root.currencies)

  gender: (options) ->
    return dummyjson.utils.randomArrayItem(options.data.root.genders)

  genre: (options) ->
    return dummyjson.utils.randomArrayItem(options.data.root.genres)

  movie: (options) ->
    return dummyjson.utils.randomArrayItem(options.data.root.movies)

  occupation: (options) ->
    return dummyjson.utils.randomArrayItem(options.data.root.occupations)

  loremja: (totalSentences, options) ->
    if !options
      options = totalSentences
      totalSentences = 1

    items = japaneseText.split("\n")

    ret = ""

    for i in [1..totalSentences]
      sentence = dummyjson.utils.randomArrayItem(items)
      sentences = sentence.split('、')
      if sentences.length > 2
        sentence = sentences[-1..]  # end
      ret = ret + sentence

    ret = ret.trimRight()
    return ret

  random: (text, options) ->
    items = []
    for val in text.split(',')
      val = val.trim()
      if val != ""
        items.push(val)
    return dummyjson.utils.randomArrayItem(items)

  date: (min, max, format, options) ->
    console.log format
    result = dummyjson.helpers.date(min, max, format, options)
    if format == 'unix'
      return result * 1000
    return result
