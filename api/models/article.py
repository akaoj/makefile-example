class Article(object):
    def __init__(self, title, content, author):
        self.title = title
        self.content = content
        self.author = author

    def to_dict(self):
        return {
            'author': self.author.to_dict(),
            'content': self.content,
            'title': self.title,
        }
