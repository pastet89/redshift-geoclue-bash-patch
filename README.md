## Bash geoclue patch for redshift

### About

Redshift is a great desktop app that reduces the blue light of the computer screeen.
This helps us sleep better and prevents our sight from damaging. In order to run
properly, redshift needs the long/lat geografical coordinates of the computer
in order to know what degree of darkness is naturally present in this area.
Unfortunatelly, as reported [here](https://github.com/jonls/redshift/issues/318): many
people can't run redshift as it tries to get those coordinates from geoclue, but for
some reason this is not working and prevents the script from starting at all. This simple patch
slightly modifies [@sbrl](https://github.com/sbrl)'s great solution of this problem.
It first tries to get the coordinates from ipinfo.io and if it fails, runs the program with default
coordinates of 0:0.

### Requirements:

1. Linux environment
2. Redshift
2. jq

### Installation:

The patch assumes that you have already installed redshift.
You will need also ```jq```:

```
sudo apt-get install redshift jq
```

Make the script executable:

```
chmod 775 redshift.sh
```

### Usage:

```bash redshift.sh```


### Acknowledgments:

Thanks to [@sbrl](https://github.com/sbrl) for his great ideas.
