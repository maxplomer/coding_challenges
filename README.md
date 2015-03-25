#Concept:
This site is inspired by codechef.com, and it functions as a coding challenge site where users can earn points by completing Ruby, JavaScript and SQL challenges.  Points are calculated depending on whether the challenge is easy medium or hard and badges are earned at certain point levels

#Technologies:
The site is a Ruby on Rails app with a PostgreSQL database.  New challenges can be added by an admin user account.  User submitted Ruby code is evaluated in a sandbox on the server, user submitted JavaScipt code is extracted using jQuery and evaluated in the browser, and SQL queries are filtered for dangerous keywords and evaluated on a separated database.  Ace, the High Performance Code Editor for the Web, is used for syntax highlighting of code in proper language.

#Todos:
- switch ruby sandboxing from shikaski to safemode gem
- Adding backlog of coding challenges
