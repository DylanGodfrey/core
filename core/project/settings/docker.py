if IN_DOCKER:  # type: ignore # noqa: F821
    print('Running in Docker (docker.py)')
    assert MIDDLEWARE[:1] == [  # type: ignore # noqa: F821
        'django.middleware.security.SecurityMiddleware'
    ]
else:
    print('Not in docker (docker.py):', IN_DOCKER)  # type: ignore # noqa: F821
