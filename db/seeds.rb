# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
	Question.create(title:"My first question", content:"How to patch KDE on FREEBSD?", parent_question_id:0)
	Question.create(title:"My second question", content:"How to make smoozie?", parent_question_id:0)
	Question.create(title:"My third question", content:"How to eat sushi?", parent_question_id:0)

	#Comments 
	Question.create(title:"My first comment", content:"Just do it, silly! ", parent_question_id:1)
	Question.create(title:"Wow wow", content:"Troll in the thread! ", parent_question_id:1)
	Question.create(title:"Mod-tan", content:"Do it once again and I'll banhummer you! ", parent_question_id:1)
	