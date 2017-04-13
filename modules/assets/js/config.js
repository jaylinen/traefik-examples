'use strict'

// More info https://github.com/hakimel/reveal.js#configuration
var RevealJsConfig = {
  controls: true,
  progress: true,
  history: true,
  width: 1600,
  height: 1200,
  transition: 'linear',
  slideNumber: 'c',

  // More info https://github.com/hakimel/reveal.js#dependencies
  dependencies: [
    { src: '../assets/revealjs/plugin/markdown/marked.js' },
    { src: '../assets/revealjs/plugin/markdown/markdown.js' },
    { src: '../assets/revealjs/plugin/notes/notes.js', async: true },
    { src: '../assets/revealjs/plugin/highlight/highlight.js', async: true, callback: function() { hljs.initHighlightingOnLoad(); } }
  ]
};
