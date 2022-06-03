# TopGithubRepos
Lists the top 100 Github repositories and their contributors

I ran out of time, possibly due to a bit of over engineering :)

Here are some items that are not completed:
1. No comments were added. Typically, I would add them were appropriate, such as for public methods or variables.
2. The view that lists the contributors for a repo currently only fetches the first page.
3. I didn't have time to create custom table view cells, so the UI is quite ugly.
4. The contributor list uses the default cell image, but the image size is not correct, so it starts small and grows after scrolling. I would have created a custom cell for this normally.
5. The title in the contributor list view is truncated. I would normally create a custom view for this.

If I were to do this again, I might explore using a collection view instead, and utilize a diffable datasource.
