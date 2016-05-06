# DynamicHeight
Dynamic height cells for iOS

[![https://gyazo.com/0753ca564b2cc06235faae25a13d028e](https://i.gyazo.com/0753ca564b2cc06235faae25a13d028e.gif)](https://gyazo.com/0753ca564b2cc06235faae25a13d028e)

I use a drop-down list to demo the dynamic cell height for iOS. There are some key things:

1. In the collection view, we use ```self.collectionViewFlowLayout.estimatedItemSize``` method. The size is for the drop-down list folded status.

2. In the ```MSDropDownViewCell.m```, I overwrited the method ```preferredLayoutAttributesFittingAttributes```. The method will depend on collection view hidden/show status, content size, and maximun height to dertimine the cell height.

# Important !!!

* preferredLayoutAttributesFittingAttributes, will be called by framework 3 times. I printed out the in the console:
    * 1st: The layoutAttributes frame height is current (57.5). The collection view frame height is zero.
    
     ```(lldb) po layoutAttributes 
<UICollectionViewLayoutAttributes: 0x7fa405c290e0> index path: (<NSIndexPath: 0xc000000000000016> {length = 2, path = 0 - 0}); frame = (15 12; 384 57.5);``` 

     ```(lldb) po self.collectionView
      <UICollectionView: 0x7fa40606c800; frame = (0 57.6667; 384 0);```

    * 2nd: The layoutAttributes frame height is changed as our setting (534.4). But, the collection view frame height is still zero.
     
    ```(lldb) po layoutAttributes
<UICollectionViewLayoutAttributes: 0x7fa405c16370> index path: (<NSIndexPath: 0xc000000000000016> {length = 2, path = 0 - 0}); frame = (15 12; 384 534.5);```

    ```(lldb) po self.collectionView
    <UICollectionView: 0x7fa40606c800; frame = (0 57.6667; 384 0);```

      * 3rd: The collection view height is changed to our expected height.
      
      ```(lldb) po layoutAttributes
<UICollectionViewLayoutAttributes: 0x7fa403d516a0> index path: (<NSIndexPath: 0xc000000000000016> {length = 2, path = 0 - 0}); frame = (15 12; 384 534.5); ```

      ```(lldb) po self.collectionView
<UICollectionView: 0x7fa40606c800; frame = (0 57.6667; 384 477);```


The behaviors are similar to 

    * Before changing self-sizing cell
    
    * Validated changing self-sizing cell again after other cells recalculated.
    
    * Did changed self-sizing cell

But the if you change the frame information change in the during changing status. i.e, in the second call, you change your frame. It will call more times until your layoutattributes frame did not change.

If you put some codes as below in ```preferredLayoutAttributesFittingAttributes```

```
CGRect frame = layoutAttributes.frame;
frame.size.height = frame.size.height + self.collectionView.contentSize.height;
UICollectionViewLayoutAttributes* newAttributes = [layoutAttributes copy];
newAttributes.frame = frame;
return newAttributes;
```

The frame size will always change in every time call. It will run infinite-loop and crash the application.
