# Clone

```bash
git clone https://github.com/lancs-macro/housing-observatory
git clone https://github.com/lancs-macro/uk-housing-observatory-dashboard
git clone https://github.com/lancs-macro/international-housing-observatory-dashboard
```

## Update

```bash
cd uk-housing-observatory
Rscript R/update.R
git commit -am "version update"
git push
cd ..
```

```bash
cd ../international-housing-observatory
Rscript R/update.R
git commit -am "version update"
git push
cd ..
```

```bash
cd ../housing-observatory
make
git commit -am "version update"
git push
```