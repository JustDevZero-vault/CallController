If you are thinking about making CallController better, or you just want to hack on it, that’s great!
Here are some tips on how to set up a CallController workspace and how to send a good pull request.

## Setting up the Workspace

* Make sure you have a [GitHub account](https://github.com/signup/free).
* [Fork the repository] on GitHub.
* Clone your fork.
  ```bash
  $ git clone git@github.com:<your-username>/calcontroller.git
  $ cd callcontroller
  ```
* Ensure you have controll over GEM_HOME, otherwise install [gem home](https://github.com/postmodern/gem_home)
  ```bash
  $ gem_home vendors
  ```

## Configure database
- Create a YML file outside of the clone.
  ```bash
  $ mkdir -p ../private/configs
  $ cp database.yml.example ../private/configs.yml
  $ cp config.ru.example config.ru

  # Edit database with your config specs
  $ emacs  ../private/configs/database.yml
  ```

- Install the dependencies via:
  ```bash
  $ bundle install
  ```

- Test if it runs with:
  ```bash
  $ sh callcontroller.sh start
  ```

By default, callcontroller will run on port 3000, you can change it if you want on unicorn.conf.rb

## Changing the Code
Checkout a new branch and name it accordingly to what you intend to do:
- Features get the prefix `feature-`.
- Bug fixes get the prefix `fix-`.
- Improvements to the documentation get the prefix `docs-`.
```bash
$ git checkout -b <branch_name>
```

Open your favorite editor, make some changes, run the tests, change the code, run the tests,
change the code, run the tests, etc.

- Please try to follow https://github.com/bbatsov/ruby-style-guide


## Sending a Pull Request

- Commit your changes (**please follow our [commit message conventions]**):
  ```bash
  $ git commit -m "..."
  ```
- Push to your github repo:
  ```bash
  $ git push origin <branch_name>
  ```
- Go to the GitHub page and click "Open a Pull request".
- Write a good description of the change. Simple is better, we strongly believe in KISS.

After sending a pull request, other developers will review and discuss your change.
Please address all the comments. Once everything is all right, one of the maintainers will merge
your changes in.


## Contributor License Agreement
Please sign our Contributor License Agreement (CLA) before sending pull requests as a contributor.
For any code changes to be accepted, the CLA must be signed. It's a quick process, we promise!
- For individuals we have a [simple click-through form].
- For corporations we'll need you to print, sign and one of scan+email, or mail [the form], between you an us, the first is faster.

## Additional Resources

- [Issue tracker](https://github.com/justdevzero/callcontroller/issues)
- [General GitHub documentation](http://help.github.com/)
- [GitHub pull request documentation](http://help.github.com/send-pull-requests/)

[commit message conventions]: git-commit-msg.md
[simple click-through form]: http://lsys.net/legal/contributor-license-agreement
[the form]: http://lsys.net/legal/corporate-contributor-license-agreement
[Fork the repository]: https://github.com/justdevzero/callcontroller/fork
