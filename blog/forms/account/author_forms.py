# Django imports
from django import forms
from django.contrib.auth.models import User

# Blog app imports
from blog.models.author_models import Profile


class UserUpdateForm(forms.ModelForm):
    """
        Creates form for user to update their account.
    """
    email = forms.EmailField()

    class Meta:
        model = User
        fields = ['first_name', 'last_name', 'username', 'email',]


class ProfileUpdateForm(forms.ModelForm):
    """
       Creates form for user to update their Profile.
    """
    class Meta:
        model = Profile
        fields = ['image', 'banner_image', 'job_title', 'bio', 'twitter_url',
                  'github_url', 'facebook_url', 'instagram_url']
