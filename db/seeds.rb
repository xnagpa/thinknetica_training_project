# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Question.create(title: 'My first question', content: 'How to patch KDE on FREEBSD?')
Question.create(title: 'My second question', content: 'How to make smoozie?')
Question.create(title: 'My third question', content: 'How to eat sushi?')

# Comments
Answer.create(content: 'Just do it, silly! ', question_id: 1)
Answer.create(content: 'Troll in the thread! ', question_id: 1)
Answer.create(content: "Do it once again and I'll banhummer you! ", question_id: 1)
