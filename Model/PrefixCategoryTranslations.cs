﻿namespace PassarinhoContou.Model
{
    public partial class PrefixCategoryTranslations : BaseModel
    {
        public int PrefixCategoryId { get; set; }
        public int LanguageId { get; set; }
        public string CategoryText { get; set; }

        public virtual PrefixCategory PrefixCategory { get; set; }
    }
}
