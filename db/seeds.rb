# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  enginestatues = Enginestatus.create([{id: 1, name: '整備前'},  {id: 2,  name: '整備中'}, 
   {id: 3,  name: '完成品'},  {id: 4,  name: '出荷準備中'},  {id: 5,  name: '出荷済'}, {id: 6,  name: '廃却済'}])
