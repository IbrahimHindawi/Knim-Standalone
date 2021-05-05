# nim-init

## purpose
The goal of this project is to streamline Nim integration with C projects<br>
by using a dynamic library to import C and debug it in VS Code<br>
then using nim C code-gen to inject it into any C build system.<br>

## description
quick Nim project initialize with VS Code tasks.<br>
quick to initialize a Nim & C project quickly.<br>
customize NimScript for different CPUs & OSs.<br>

## pre-requisites:
build the dynamic library to run. HINT: look at ```main.c```

## tasks include:
<li>nim build & run current file with dynamic library</li>
<li>nim debug current file</li>
<li>nim code-gen to cache directory</li>

## todo:
<li>bonus: automate gcc to build project using nim's code gen using cmake?</li>