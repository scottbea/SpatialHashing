[discussion thread]: https://devforum.roblox.com/t/SpatialHashing-v2/1017701
[resources]: https://scottbea.github.io/SpatialHashing/resources/
[Material for MKDocs]: https://squidfunk.github.io/mkdocs-material/
[ForeverHD on the devforum]: https://devforum.roblox.com/u/ForeverHD/summary
[SpatialHashing repository]: https://github.com/scottbea/SpatialHashing
[open an issue]: https://github.com/scottbea/SpatialHashing/issues

## Bug Reports
- To submit a bug report, [open an issue] with label ``Type: Bug`` or create a response at the [discussion thread].
- Ensure your report includes a detailed explanation of the problem with any relavent images, videos, etc (such as console errors).
- Make sure to include a link to a stipped-down uncopylocked Roblox place which reproduces the bug.

## Questions and Feedback
- Be sure to check out the documentation and [resources] first before asking a question.
- We recommend submitting all questions and feedback to the [discussion thread].
- You can also [open an issue] with label ``Type: Question``.

## Submitting a resource (video tutorial, port, etc)
- Fancy making a tutorial or resource for SpatialHashing? Feel free to get in touch and we can provide tips, best practices, etc.
- We'll feature approved resources on the [resources] page and often the [discussion thread].
- To submit a resource, [open an issue], or reach out on the [discussion thread] or to [ForeverHD on the devforum].

## Suggestions and Code
- SpatialHashing is completely free and open source; any suggestions and code contributions are greatly appreciated!
- To make a suggestion, [open an issue] with label ``Type: Enhancement`` or create a response at the [discussion thread].
- Please open a suggestion before beginning a code contribution to ensure it's discussed through fully (we wouldn't want to waste your time!).
- Some tools you'll find useful when working on this project:
    - [Rojo](https://rojo.space/docs/)
    - [Material for MKDocs]
    - [Roblox LSP](https://devforum.roblox.com/t/roblox-lsp-full-intellisense-for-roblox-and-luau/717745)

## Documentation
- If you find any problems in the documentation, including typos, bad grammar, misleading phrasing, or missing content, feel free to file issues and pull requests to fix them.
- API documentation should be written at the top of the corresponding module under ``--[[ module:header``. These comment blocks are automatically converted into markdown files and deployed to the site when pulled into the ``main`` branch.
- To test documentation:
    1. Install [Material for MKDocs].
    2. Visit the [SpatialHashing repository].
    3. Click *Fork* in the top right corner.
    4. Clone this fork into your local repository.
    5. Change directory to this clone ``cd SpatialHashing``.
    6. Swap to the development branch ``git checkout development``.
    7. Call ``mkdocs serve`` within your terminal.
    8. Open your local website (it will look something like ``http://0.0.0.0:8000``)
    9. Any changes to ``mkdocs.yml`` or the files within ``docs`` will now update live to this local site.
   
!!! important
    All pull requests must be made to the ***development*** branch.