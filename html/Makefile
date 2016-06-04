html: build/app.js build/app.css build/index.html

build/app.css: src/app.scss
	sass --scss src/app.scss build/app.css

build/index.html: src/index.html
	cp src/index.html build/index.html

build/app.js: src/elm/*.elm
	elm-make --yes --output build/app.js src/elm/App.elm