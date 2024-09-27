import pandas as pd


COUNTRIES = pd.read_csv("countries.csv").iso_a3


rule draw_country:
    output:
        country = "countries/{iso_a3}.png"
    run:
        import geopandas as gpd
        import matplotlib.pyplot as plt

        world = gpd.read_parquet("admin-level-0.geoparquet")

        f, ax = plt.subplots()
        world[world.GID_0 == f"{wildcards.iso_a3}"].plot(ax=ax)
        ax.set_title(f"{wildcards.iso_a3}")
        f.savefig(output.country)


rule all:
    input:
        countries = expand(f"countries/{iso_a3}.png", iso_a3=COUNTRIES)
