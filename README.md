# launchbar2alfred

Reads all search templates from [LaunchBar](http://obdev.at/launchbar/) and outputs a plist formatted to be used with [Alfred](http://www.alfredapp.com/) (complete with the custom searches you already added to Alfred, if any.)

Requires the `plist` gem, so run `gem install plist` first.

# Sample usage

Quit Alfred.  Then, from Terminal:

    git clone https://github.com/dipnlik/launchbar2alfred.git
    cd launchbar2alfred
    gem install plist
    ./merge_searches > ~/Desktop/customsites.plist
    open "$HOME/Library/Application Support/Alfred/customsites"

You should now have a Finder window showing Alfred's configuration folder. Backup the `customsites.plist` file in this folder (hint: right click, Compress...) and replace it with the one in your desktop.
