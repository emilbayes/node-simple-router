#!/usr/bin/env coffee

Router = require './router'
http   = require 'http'

router = Router({list_dir: true})

server = http.createServer router

argv = process.argv.slice 2
server.listen if argv[0]? and not isNaN(parseInt(argv[0])) then parseInt(argv[0]) else 8000

#router.get "/", (req, res) ->
#  res.end "Inicio"

router.get "/hello", (req, res) ->
  res.end "Hola, Mundo!"

router.get "/users", (req, res) ->
  res.writeHead(200, {'Content-type': 'text/html'})
  res.end "<h1 style='color: navy; text-align: center;'>Registro de Socios Activos</h1>"


router.post "/users", (req, res) ->
  router.log "\n\nBody of request is: #{req.body.toString()}\nRequest content type is: #{req.headers['content-type']}"
  router.log "\nRequest Headers"
  router.log "#{key} = #{val}" for key, val of req.headers
  router.log "\nRequest body object properties"
  res.write "\nRequest body object properties\n"
  try
    router.log "#{key}: #{val}" for key, val of req.body
    res.write "#{key}: #{val}\n" for key, val of req.body
  catch e
    res.write "Me parece que Ud. es un pelotudo, mire lo que hizo: #{e.toString()}\n"	
  res.end "#{req.body.toString()}\n"	
	
router.get "/users/:id", (req, res) ->
  res.writeHead(200, {'Content-type': 'text/html'})
  res.end "<h1>Socio No: <span style='color: red;'>#{req.params.id}</span></h1>"

console.log "Serving web content at #{server.address().address}:#{server.address().port}"