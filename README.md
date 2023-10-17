[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/a2fQs4QM)
# Lexer & Parser for the Tokki Language
Westmont College CS 105 Fall 2023
Chapter 4 Assignment A

## Author Information
- **Levi Wicks** lwicks@westmont.edu
- **David Ponce De Leon** dponcedeleon@westmont.edu
- **Alexis Leon** alleon@westmont.edu

## Overview
This program is a lexical analyzer written for the language Tokki. The lexer takes in a file as input and returns the formatted tokens. 

## Design Notes
When developing the lexer we chose to deviate from the books implementation and put it all in a single function. Instead of creating a lookup function which utilizes switch statements, we took advantage of Luas *table* datatype. 

## Lessons Learned
While creating the Tokki lexer in Lua, we learned:
- How basic file IO works in Lua
- Basic string formatting, and concatenation
- The difference between calling static, and non-static methods on objects (using either the . or : operator)
- What different basic expressions evaluate to 
