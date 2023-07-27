# Generated by Django 4.2.3 on 2023-07-27 17:11

import apps.flashcards.validators
from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("flashcards", "0003_flashcard_back_flashcard_front_alter_wordimage_image"),
    ]

    operations = [
        migrations.AlterField(
            model_name="flashcardstyle",
            name="back",
            field=models.FileField(
                upload_to="",
                validators=[apps.flashcards.validators.validate_style_filetype],
            ),
        ),
        migrations.AlterField(
            model_name="flashcardstyle",
            name="front",
            field=models.FileField(
                upload_to="",
                validators=[apps.flashcards.validators.validate_style_filetype],
            ),
        ),
    ]
