import { Component } from '@angular/core';
import { NavController, NavParams } from 'ionic-angular';

import { SuffixCategoryService } from '../../providers/model-services/suffix-category-service';
import { SuffixCategory } from '../../models/suffix-category'

import { MessageSuffixPage } from '../send-message/message-suffix'

import { SendMessageService } from '../../providers/send-message/send-message-service';

@Component({
  templateUrl: 'build/pages/send-message/suffix-category.html',
})
export class SuffixCategoryPage {
  suffixCategories: Array<SuffixCategory>;

  constructor(
    public navCtrl: NavController, 
    navParams: NavParams,
    suffixCategoryService: SuffixCategoryService,
    private sendMessageService: SendMessageService) {
    this.suffixCategories = suffixCategoryService.getAll();
  }

  suffixCategoryTapped(event, suffixCategory) {
    this.sendMessageService.SuffixCategory = suffixCategory;
    console.log('sendMessageService.SuffixCategory.Name', this.sendMessageService.SuffixCategory.Name);
    this.navCtrl.push(MessageSuffixPage);
  }
}