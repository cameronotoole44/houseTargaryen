# House Targaryen

A web application built to explore the lineage of House Targaryen from _A Song of Ice and Fire_ by George R.R. Martin. I built this to help navigate the wild, tangled web of this house, because let’s be real: the Targaryens have _a lot_ going on! This app brings their history to life in a terminal-themed interface.

## Technologies

- **Flask**: Python web framework for routing and rendering.
- **PostgreSQL**: Database for storing Targaryen data, relationships, and dragons.
- **CSS**: Vanilla CSS, with a terminal aesthetic.

## Views

- **Targaryen List**: A paginated list of all Targaryens with sorting options
  ![Targaryen List](./gifs/lineage_look.gif)
- **Individual Profiles**: Detailed profiles for each Targaryen.
  ![Targaryen List](./gifs/individual_look.gif)
- **Dragons List**: A detailed list of dragons.
  ![Targaryen List](./gifs/dragons.gif)
- **Relationships**: Displays parent-child and spouse relationships.
  ![Targaryen List](./gifs/relationships.gif)
- **Search**: Search functionality to find Targaryens by name.
  ![Targaryen List](./gifs/search.gif)

## Security

- **CSRF Protection**: Implemented with Flask-WTF to safeguard form submissions against Cross-Site Request Forgery attacks.
- **Rate Limiting**: Utilizes Flask-Limiter to restrict search requests to 10 per minute, preventing abuse.
- **Logging**: Integrated with Python’s logging module to track search attempts and errors, enhancing monitoring and debugging.

## Credits

- **Data Source**: [A Wiki of Ice and Fire](https://awoiaf.westeros.org/) for Targaryen lineage and details.
- **Artists for Images Used**:
  - amoratearte
  - Hylora
  - Amok
  - laurelizabetharts
  - Riotarttherite
  - Chillyravenart
  - Mathia Arkoniel
